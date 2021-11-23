Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7845ACBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbhKWTot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhKWTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:44:48 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB3AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:41:40 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f20so367939qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=W0IoztZa1aYNcuaemgTTzm3oXD1cnzGe862rdAhu/FU=;
        b=lzlPT7B7Lx1k2539LlSi05ddX4kU+vQVd8a95D17FrEa2gseKLZpaD0GX2OZp/WwV3
         b7mCnkOwV/PKPqTERVaRBNTfXMJ/pv0WNp1syhl+uVWQqnCEfpCg+TJwYkDy1SvAKTTm
         FkENGyTAVbimoT8ry0/QKFPjzpTBvoz13OttYPE7xVkQPSUylhQo/OovN6Fq6bf9ooM9
         l1Fej4j28SiPBqTa2NqrKpmnDLmQiTwWX+2DkMR3HCajoBsntYcWkCFdm6WLAGTRzK+K
         Ph5Zh0lTMWK3aNC/9XcFOcwpbG/F1jtbcirjrNG+UjD0w2FmOTniojeqYytGHkol6sHv
         hWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=W0IoztZa1aYNcuaemgTTzm3oXD1cnzGe862rdAhu/FU=;
        b=x9NI6voSXaIo9WJ1GGtP7XWX6JeJ2GTkAWUjWVBLrAM0QcvBkfl0ww9SHhpf9KD6OR
         pLUeo0usIpOsYnQ1BG14ycB8EozqyXLK8anaXwPwP69QvOQLscgsoDYz67s36t7poKph
         3uyvrLIi7pdAyyjRenNbd1CLf+W/6aXMc4hPzVI/p9Webm8hU/OBZ5vO3OUJcC/e+ZMS
         jcLuA/48ooV5MH2IZhThnFDM91fStSaTtXgpXXc2O2Z8/QaOtSGx3GLSoapoeH3p2P6j
         QAzqV0uHEy70ic6G1NDW5JAxwtFFM2cGHlrI0BynOPuO9tNYckuTGHGLOakWipqKsV2i
         48vg==
X-Gm-Message-State: AOAM530qZTmrAVo/se965ftsds3f+hm8QwDaC6WhYPymXQSsCagPlZES
        41G5I0pMkBzhM+rqsobHv/KJnt6YmMV/u+LCaE8=
X-Google-Smtp-Source: ABdhPJzgEj6Kvm1TBGXtc/UyOKKLvq16cyyLXL7x/b/7qkkdY/REZCBT04LciiZlHvPmFgz2JX5jZNdXC9ZuZ6lAdco=
X-Received: by 2002:a05:622a:15c5:: with SMTP id d5mr9345543qty.227.1637696499275;
 Tue, 23 Nov 2021 11:41:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac8:5a4e:0:0:0:0:0 with HTTP; Tue, 23 Nov 2021 11:41:39
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <colonelrachelwashburn6@gmail.com>
Date:   Tue, 23 Nov 2021 11:41:39 -0800
Message-ID: <CAGoywpMRWjWd=4_b-D_NrQ2oZ=NhEm51gaSQFojE+hce73tNsw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi, did you see my message i sent to you?
