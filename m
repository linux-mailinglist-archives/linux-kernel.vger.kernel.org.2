Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F73429F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 03:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCTCQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 22:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCTCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:16:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBF4C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 19:16:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y6so12946263eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 19:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=lCesJamBNqroHsQblgO5UWKPy+JUA8j7IhgXX+n6vnU=;
        b=j2/fs4BMVsTNaof/YddxGVqR2yYashsj/4jSY9r8TP1C/TbZ7vc1RwzjXmlVbqQiYw
         b4KtFQ20pxgyfVkcJBVpZRffMzTAPf+TsVqiMwWlTKNXhsGNl9budkZ7IZRbLODaSmbO
         Fgi5SORSLHgoN2ai6tJI6ESC+ihfzPRt15IQrNyv2K4DKZukZnxXfXPUYEhvTsgn6lKu
         Ptuyog90pozZ9faEAvfRUN7gziRn5yHUlUswgY6ERHILj4lNQfXWIehepGiEtYwI2SJ/
         PiWnSKf5fUUadDIy1+wfHqN4xuSbjGWCD15a1f3GJOytok0GqlTDX/dVKp5BL+UpzHPq
         d3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=lCesJamBNqroHsQblgO5UWKPy+JUA8j7IhgXX+n6vnU=;
        b=lwklqImQ7THojymZyNT0rBxbHxo11Ksx/l1S4OULUymYB7CrVwmHWVkriW0SXe6uu5
         viDs/RVT8jeJh1X4DUZvQYdPisIlwCISvBBC+iySXXCnh5dIBlutJglx2pUVHU4XOC/C
         WB6Sn4m3yVEfopCAiQYzmBBxa1oXfEXtHNKLFmjfkUlkpjsgQVmWbXtLws/FQtKZK02s
         J/UEg/Jbqc5oWEyU0qJcYMQMH/Onz+CsG32HfQec8sLFdoD5DPip3adpmBF1r818KUCg
         RWwJuq4SVXqnk5EpwHrYPDKK9P04bu1UuhQrxPjF/r1UBL6TVVo6cPNSltt8ntLqO2OX
         77Kg==
X-Gm-Message-State: AOAM5303P2V5CrAjDmE3qZ1ycfR7ZNWtAiAh5jmzB3JDYiT/YEI2goux
        fqdjTRNLRl7VrYgIDD7SI/gTb1uFq+68mKwp2mI=
X-Google-Smtp-Source: ABdhPJwA6a5r4K10om2GXf52C/BoBOlXEe8c5wcS0l5CBoVx1UsYGGjeNjXgWF9CySpHdv4bnpapfWTEFXgjFp9D3xA=
X-Received: by 2002:a05:6402:1649:: with SMTP id s9mr13110921edx.177.1616206585264;
 Fri, 19 Mar 2021 19:16:25 -0700 (PDT)
MIME-Version: 1.0
Sender: seabraham97@gmail.com
Received: by 2002:a54:2f4a:0:0:0:0:0 with HTTP; Fri, 19 Mar 2021 19:16:25
 -0700 (PDT)
From:   Kayla Manthey <sgtmanthey1@gmail.com>
Date:   Sat, 20 Mar 2021 02:16:25 +0000
X-Google-Sender-Auth: zyoTGSSkcV8Dt-ZcxxOWDO9ciYM
Message-ID: <CANDRGHiDW1P3faf7z7_TCbENw3mox3G6+kFJXZ1WZN2q7M3a=g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ik wil alsjeblieft weten of je mijn vorige berichten hebt ontvangen.
