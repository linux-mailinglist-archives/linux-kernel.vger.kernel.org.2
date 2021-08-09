Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811F23E4692
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhHIN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHIN2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:28:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5B7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 06:27:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u3so29003622ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=lIEHTypOMV6OIwvhIProWzVfgV7bT0xhlTel77/g5/w=;
        b=cOK7LN50P0rVL0Ks4tgkX4WHNHA2xJ1yKJQQ8a7eggKyKgu9uwyx1Gm71IXgzPL7PC
         v753LirX2jC8HP38crjvoRTF6BioxoGT8k/rwNhLNCKhd5sHrCVi7khU+M3J1LpulWPu
         YJwEg741DW9Jpj7S37PHpM6xNMd6vJfnGUezFpuSw8iL4iGGJR6ZGoghF1b5H/Cb+EWN
         nLRf1uYW7BHRX+z5uge8W8epHTQD3AoWcLvMgr1nBIUsjEzMkwQLda40CXx5q6acBTan
         tKzvjqG1MIT971P8Ry0R2uIQW8bx3VMvzX86rEUtmB87+xDV8J5jNoeJmFOD1Cz9LyOS
         M59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=lIEHTypOMV6OIwvhIProWzVfgV7bT0xhlTel77/g5/w=;
        b=b99RhnNWrKE3HR1AioCXe1ghBBoke+faaoFXoQUbrJWnRJ8bgiq1XwCc85og2ChfBw
         CKE5oCDKAMc/5SeHX3T1qYftP/INPROW8hI035qd1FACZIM3t9grBZGJGKV6ztiTKHZD
         tgUDE1Pp0/wx9yAr0U29waGdOSHlxM4CpOzSseiETTNkEbmasCW557rM26mZJ03LWLcP
         e7aTjDlaHpnaPDlraxuOpARxgLEAGp3VWWairqEg5HEokBds+O6gTq+johgFth8A8xAJ
         ew/n5KGoktfrZGyCed4QOEhZnWziYDt9E0ffXAh/unKu2HmoLfxnQIgY6ZLcel98UMY2
         eFxQ==
X-Gm-Message-State: AOAM531AL1XR5ge7UEwZxRTMpekaJLAw4pvQlv7e/fswj3pDMTF7b5kk
        XBTmLFnEzIWTbvsEOnEvD9WdHSQDv9g=
X-Google-Smtp-Source: ABdhPJx7gEPHcUs9aViJR+QqwoOQujoxTmgMQj3jkabrlNVS1+qRRcxc5eXf6G/mJ8VSE/z2IZDFPQ==
X-Received: by 2002:a17:907:7da5:: with SMTP id oz37mr22066868ejc.396.1628515672457;
        Mon, 09 Aug 2021 06:27:52 -0700 (PDT)
Received: from skbuf ([188.25.144.60])
        by smtp.gmail.com with ESMTPSA id lk14sm5912316ejb.9.2021.08.09.06.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 06:27:52 -0700 (PDT)
Date:   Mon, 9 Aug 2021 16:27:51 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: info@cestasdeplastico.com spam
Message-ID: <20210809132751.kwmgd2movxgoc4v6@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I send an email to a few mailing lists, like
linux-kernel@vger.kernel.org, and (I believe)
linux-arm-kernel@lists.infradead.org, I get an auto-reply from said
email address which says:

	Hemos recibido correctamente su consulta, en breve le contestaremos. Gracias.

It is really annoying. Can we make it stop?
