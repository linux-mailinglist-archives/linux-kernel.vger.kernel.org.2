Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA8427A25
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhJIMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhJIMgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 08:36:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139DFC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 05:34:28 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id p4so12200050qki.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=FLGhN4fnuusLIGZMWIrjPRNVn80RK3lbiS5XqHk2rXc=;
        b=e1IW9F9KgvjKflBCtt3Re/3tWq4lm5dI6ztOVTsmTzwN48R3XiApNMDO7radJTO2ak
         lSeR7vhXAnVO+ulNJOSECbs+jK8oIfy2wtgY+ijPIZC+bk82yet0Vr5CYOystCLWDJAE
         HOL9QNkYL9tTxTL35Mh7ghWpzA3WKOvodG0mYizhYOQ9wkYluGAOkqzGq6Ryc7KIN+IC
         VmasGgMwgJ8AbPZ4CKj0P90OuBpuPlZSZbJkagzwAcze1geAn8GJK66L/5YZ0DcBH+Vs
         AjcicVMyg51KFmIl22h8XOIr45dm0ocjpvmhGTb8tACJarUNlywcJfBspOgsXRNQit7p
         SGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=FLGhN4fnuusLIGZMWIrjPRNVn80RK3lbiS5XqHk2rXc=;
        b=7Xy2wLpo7Z7rFj6kPmtOM8+U63xdIOEx13saVLzzPBuv80cfQIdyhLN0z8pst/sLiu
         sXyUq/kO6xp0InArn93dmuu+2PU7+ZaI6dYUgcST7Ur5NVcz8Hgs8Vt4KJOX0MK0iOtt
         I/VIVjA30KAbOlEaqORzD0y9ZEMniXPW/BCJ6tvsUVycQXX+roR0NnIrK9m+Wgu7oDrq
         poVH+eY02ta2rMsWs/Y4YboOXwt7MTYxSw3mP0hDUk6E9zrhkuDDdJf615v37SF1VNWl
         Y4NB3kOTGHAbGFTLVxA9wX6c0dIpTslTU5LCU04Yn01RwzmD7gnHt2fN6qM+h1rFCL6a
         h+1g==
X-Gm-Message-State: AOAM531rQGFCGRHFwSOmoT5kXZYKccK3q6VKwLziAw0dlXCGErVi/xvG
        GAhYbdEC22D8e4MrQ+aiTsgEufOkkbDPrfjMgoU=
X-Google-Smtp-Source: ABdhPJwxuJJl3wL327rFKWcfxQ7QKSKusqI4iqh9bhVrOADkLVkCvr/QaYs/HMBZyk39hKAakL8eoS0WnjpAtHQlU24=
X-Received: by 2002:a05:620a:1a2a:: with SMTP id bk42mr6107137qkb.209.1633782867146;
 Sat, 09 Oct 2021 05:34:27 -0700 (PDT)
MIME-Version: 1.0
Sender: reymonddennis@gmail.com
Received: by 2002:a05:622a:296:0:0:0:0 with HTTP; Sat, 9 Oct 2021 05:34:26
 -0700 (PDT)
From:   Mrs Carlsen Monika <carlsen.monika@gmail.com>
Date:   Sat, 9 Oct 2021 13:34:26 +0100
X-Google-Sender-Auth: 5u3hKSQGEXLwZbN3txAWSAdabl8
Message-ID: <CAOOE2sHQTMnawY=m647gQr7+hF+Op9XxQaNyF9CKf=f1hmO3=w@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I sent this mail praying it will found you in a good condition of
health, since I myself are in a very critical health condition in
which I  sleep every night without knowing if I may be alive to see
the next day. I am Mrs.Monika John Carlsen, wife of late Mr John
Carlsen, a widow suffering from long time illness. I have some funds I
inherited from my late husband, the sum of (elevenmilliondollars) my
Doctor told me recently that I have serious sickness which is cancer
problem. What disturbs me most is my stroke sickness.Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way i am going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages, widows and also  build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained.

I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincerely and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God bless you and your family.
Regards, Mrs. Monika John Carlsen
