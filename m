Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26663CB2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhGPGmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbhGPGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:42:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9639C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:39:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so14289027lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EgjzAt5y8xG+Dk3D+OcaLCmFF8BQUhu3tBfe+fryUGU=;
        b=eWO93Ja7/6jBd29oLyjvi1M8EG4mqlft+7OqZ2LPK5v0+F+nPNXtscTEKzT6hqCKEm
         tEM2AusTtDRvoglaVMJLfgswnCYrba4BXrSaYDNEH98Nu9dZk36RHptyIs3uGxSeE1Vj
         t309lzdDmbQGQYy+oVzJGAAJyuGL6f4lZUUjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EgjzAt5y8xG+Dk3D+OcaLCmFF8BQUhu3tBfe+fryUGU=;
        b=ABeWhMiy0l1RQU9X2iAJ/EQOx24RIWQWZONeQkHh0mojXc/KCvOsjtotLw0Cbd5aKr
         W3aNJ+6aZnyoLUhe3i1oRemOrSDOiap3HiKNjXQFhNBZve8woghUlGUdVFQ0au5dS8we
         cW4Pfts9JI9NaI/Kpq1FHBrS4uDlMk83mFFneFIBzW9drSeh2/LP4IOFcVFc5szPKV08
         OR8rXS7O1lLEwiybHmNl6T+KyFRp+mWId5UdVCUb2WxGe4FnnECqaB8qGAKRFAGHPb9z
         ntmVZhkO1esSBQqcR7RyfbGgl0oUeDupsYzKfKEMSq8LDc5AsBAG16XH2T4ACQLPXPgI
         6uqw==
X-Gm-Message-State: AOAM5306k2/wRNCBTl63RsXNN/CvyD7zDZRi1EAmdn+mKSDtIlpVfUUy
        wSI1fBEKeYqz4j1g3eeSO1SURut9AzYuA86EDxOAgB7cMOsrL1wJ
X-Google-Smtp-Source: ABdhPJw1jh/ikDYZvAVScYDvVZfmandFqXXuZ6dubclD0ke9f+rBFK0gncPu6YkcVBroyrPaf+bonRXt+tBPcGpuf0Y=
X-Received: by 2002:a05:6512:2344:: with SMTP id p4mr6397331lfu.273.1626417592850;
 Thu, 15 Jul 2021 23:39:52 -0700 (PDT)
MIME-Version: 1.0
From:   Alok Tiagi <atiagi@netflix.com>
Date:   Thu, 15 Jul 2021 23:39:42 -0700
Message-ID: <CAFfSco9ZiTAej66dmRjXEpoOECkK7tuterP0rNQvewyA4c1scw@mail.gmail.com>
Subject: seccomp: epoll issues post addfd
To:     linux-kernel@vger.kernel.org
Cc:     rodrigo@kinvolk.io, alban@kinvolk.io, sargun@sargun.me,
        Keerti Lakshminarayan <keerti@netflix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using seccomp to intercept syscalls like connect() and using
addfd to install new file descriptors into the client program. We are
running into an issue where any operations by epoll_ctl in the client
programs returns an ENOENT (No such file or directory) after the
syscall interception.

Example:
fd = socket(AF_INET, ...)
epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd, &event)
connect(fd, ...)

Post interception of the connect() syscall, the file descriptor
registered with epoll is no longer valid and any further epoll_ctl
operations in the client program fail. This is happening because the
original fd is closed causing it to be removed from the epoll
instance.

As a workaround, after addfd and before unblocking the client
program's syscall we traverse the client programs /proc to find all
epoll file descriptors that have the original fd as their target. We
then use pidfd_getfd() to get the client programs epoll_fd and perform
an EPOLL_CTL_ADD operation with the new fd that we installed using
addfd. Before EPOLL_CTL_ADD we ensure that the new fd's number matches
that of the original fd by calling dup2(). This helps further
epoll_ctl operations in the client program to find the fd.

It would be nice if this was handled in the kernel after addfd and I
am wondering if this is an issue which others are facing and if any
solutions have been thought of.

Thanks
Alok
