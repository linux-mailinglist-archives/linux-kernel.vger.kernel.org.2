Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0767F40ABB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhINKbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhINKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:31:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:30:31 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q22so11785068pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=+i5E5qU+OzPS+QTkj1VwA14AfShbKp0dEUyIGviX/aU=;
        b=cs8DlLsdvOBdtBBsnIdIHKBVOtGcju6ApV/d9rQqs/KL3/UKOTJfAJudgwnvRg63Xp
         BG/AcKAULGQm9bIwRHYgwljD5cwYnQaNtRQirSPqpEF/7YOUlCbI4XW0vI7YVIjf0+W9
         fbo2SCvpHHZFrnl6xfuybntWC8Srpk4YaZa5YxA1ESDxsQU2voAZUIC9Kc4jeNBn8MQa
         PeqoOK2U2bbPLWc95kvsXvweZuYDdLesczAlL0Kti/wUoTFXGNgZxw+qHKcYplwfMJLP
         V2+4zUakigW5ipH5ASeJkavityf7FEdLSmjKPFdnr/W0096hYsYkLwz/X6XGmmrWjqWL
         LxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=+i5E5qU+OzPS+QTkj1VwA14AfShbKp0dEUyIGviX/aU=;
        b=yloTTREZDWlxGHjzZJ5BEIzglKehke+yM5OR6CkH5yyw/cLcgtvKTq+ug5IVaH7YU6
         RUwwJxfh0OPAF/DWzSlOHRqV22Os8ZM9F/JER9gjItu20cOPT+I+pc0j4ZxeZv8nRY8q
         toT5JCVWCiSGapUur4MCHh0Xw6NLwnDee0TO5qi5WRH7JY/Cna/zNB7WWk4jLh1OpdOl
         rQwMQb8/Sh0msv1wiSm/rqIF2k6/0BZoVMIgiGEMy5pBPPRJLSA+PFtDz1YccYtD8CD9
         QQtrj7Hltnmj8G6+d0x2KOBVbpt6VOwHsvT29n6VlGErMlYSStkKUYulxIBwO+UKB8C3
         90mg==
X-Gm-Message-State: AOAM5336ZtK1VFnefb45eqLig99LMafSY6PGFyTRVrKaRe5iz/9iknfA
        OgvwRvXcAQZjW+z5mpkLOaQ0tMrbgNZnIlOcz5c=
X-Google-Smtp-Source: ABdhPJylQrG0+nV1IyXIPGLjJ2ekzCJZzLOkRjNia1AbpyQQleZK1Vfr7NHNEZdaWNsL0lxO2vewXNpZqcEJrSMr1Dw=
X-Received: by 2002:a63:1259:: with SMTP id 25mr15075747pgs.48.1631615430714;
 Tue, 14 Sep 2021 03:30:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:bb14:0:0:0:0 with HTTP; Tue, 14 Sep 2021 03:30:30
 -0700 (PDT)
Reply-To: j8108477@gmail.com
In-Reply-To: <CAOEYurTAFVMRs7gFqpK1JoMCEhzAg7Cd5g10duNqcxDtKz0B7Q@mail.gmail.com>
References: <CAOEYurTAFVMRs7gFqpK1JoMCEhzAg7Cd5g10duNqcxDtKz0B7Q@mail.gmail.com>
From:   MR NORAH JANE <jjackolino@gmail.com>
Date:   Tue, 14 Sep 2021 12:30:30 +0200
Message-ID: <CAOEYurQNPzihOKsNWe-Z_wS2DXs6H16mSqjRuuKdTV62sNiguQ@mail.gmail.com>
Subject: Fwd:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: MR NORAH JANE <jjackolino@gmail.com>
Date: Tue, 14 Sep 2021 12:29:59 +0200
Subject:
To: jjackolino@gmail.com

HI, DID YOU RECEIVE MY MAIL?
