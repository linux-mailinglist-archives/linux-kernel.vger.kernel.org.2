Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6D367222
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbhDUSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhDUSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:00:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5614AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:59:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g16so5231668plq.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmrLqvc7lvrTYfzDETwS6PCQ0B95d5REakCPjeR2+8M=;
        b=HmxN0Y2NTawIZayG7Pk/N7/KVy3uZeGOdvJcjXSrAeoLU6nnsZ/MOFlH/GBkMJCgs6
         RwXRjxXLItKGMt0T5OVXkZW6PeQhZv0ij90b7o6CKJ9+wtfA8Qg9nJhI1Wr6rH1eKrPe
         aK8Lx1oldmrqkgHw5eVFlOZWgK7Qx+mEhcG0FaxF74rIxmhtFGQnIqoQQSjKRYS5y14t
         /gAWUpWpkyhyE+L3WTXtnYHSTQpU22k25jwjmxbaY77Rf9aTQT0jMqnD72418XBK+3fE
         JMQDtCBaUlCXJUahghJ8NQBvzQG1PSJ7xFwjzKhbhmlNAWg0bliWrnvBXQ94L0UDn4Zt
         ZwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmrLqvc7lvrTYfzDETwS6PCQ0B95d5REakCPjeR2+8M=;
        b=WaUoj2QjTfDmw18RXpZdCBJac6jBFcFgfC0IQaaB8HZWQrdQrmhln0N1uSINpFDaYV
         U2mlWWjV0OVs3BtHpraBXA/5d8j/bDju0EtXNqgfpj8fJeh41gPFCIxu8HO/Bqptgjks
         vml6WzIytAtB5kD/b5tPzs0RU+lEH6RUbcOvvhKb+d1if6WqIAGM1+rpavhD1/Da7Hvn
         jl0TSYBeLqFXn4x8qRtyuimHBu7nu5G/j7d6zrxZwFwQ5vjgMdaQENYW4kb+l0ll9RMn
         Xsf75MYdT2hiVaHhVly+4BvkWMFpVXjPO9YmSM2wcAI5Rrl2a03VbRHzBJi5iMIGLZ5y
         w1ew==
X-Gm-Message-State: AOAM532SJMv3cczkP7wsq0WYpZ5pQk4RgszlNdbVm+DNMA8AN5cUttNM
        5bI6BDLIG82+9H3z1vMrmB2KF7Ucphfc9T64iFnlZA==
X-Google-Smtp-Source: ABdhPJwjsR/FAsQfOWgtmw24m+LiaqPfLdSfsMilmhgXf019kL6Eb1x7bTqCyqIOfuNmQjdjpkmd/HMaIkb0J3jq7dE=
X-Received: by 2002:a17:902:ed83:b029:ec:7aa8:439d with SMTP id
 e3-20020a170902ed83b02900ec7aa8439dmr28795870plj.28.1619027992935; Wed, 21
 Apr 2021 10:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-11-gregkh@linuxfoundation.org> <CAG3jFytfaOoJihOyxjMjzRqUOCR+fKhO_nPxVnO62Up0gvoGWg@mail.gmail.com>
In-Reply-To: <CAG3jFytfaOoJihOyxjMjzRqUOCR+fKhO_nPxVnO62Up0gvoGWg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 21 Apr 2021 19:59:42 +0200
Message-ID: <CAG3jFytYxquuvYmq8dR0repe6-QHnS9p3nrDQquB=ceCn0FD2g@mail.gmail.com>
Subject: Re: [PATCH 010/190] Revert "media: camss: Fix a reference count leak."
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this patch is good, NAK.

Let me revise this, if this series is going to be reverted in its
entirety, feel free to add my a-b.

Acked-by: Robert Foss <robert.foss@linaro.com>
