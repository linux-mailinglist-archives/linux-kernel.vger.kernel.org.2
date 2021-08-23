Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2283F4694
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHWI1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhHWI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:27:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517DBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:26:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so25012973edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=plkFbsG8fVa9CmkZK2Zfujgljkhb65tfZXNdzCcMUbQ=;
        b=ONTos8thIS3Rsw3Ml0sVEhTeBFWbxF9pLiCXAgij9nntDCbA5c2hYAOf+2VcLAQevm
         92rfUmtzpfN8Xuyej/roBMbmkPDisrs7tgIa31/aY9srdE8wGRpxG+lDhlJf5Htx0Qho
         euRD6Miiao4LP+dh19UgQPL/1dKXDfTzkN7684I7IjvnNEBRINe5SrZswL1nQvlnlRf8
         fn4RCfWnO8Nm36V/ZwPGH0xLFhWZVuLziHenr+bXwCHXAkbOxFU0LA4sTxs893V/mc4+
         Juc7FBgMuYE7qggyDbXoqgw2B9K6fm9aIzYfsFM1qEnqwyDv/SmyirDfBcKTO6BUi3M+
         8uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=plkFbsG8fVa9CmkZK2Zfujgljkhb65tfZXNdzCcMUbQ=;
        b=SM/Qst8N3EiiJdQxRHRvtqca+P7k6eMYrtqttYIwL/l+6yGfB793eCWJwRXHRU+LZ9
         AGjg41EnwY/1ChRPP/+q2EW2PTLBrGLAhDTMqOfEoXCp7XXHUajpSb7eWTDCrU4dIv/Z
         +XoAHhJW6mr9h78lSyXpGLSt7UGrw8qCY/mThaaYgC57GdJUDvvKWVV5adOB6LjGxJDI
         Nl91ARh6k7Bq7JkQEb2zr3djIYr8Nsw3cSXCOcc3coBJBTvEHK1tkRIPJD53cRlqfomW
         pKv4NTbfEojVGj97is3E2bZUz0U6SOxGCSvBD4nrk53lVrxmUKzV3WcHObP1Ltsu1dyd
         OYNg==
X-Gm-Message-State: AOAM532IZkWMd2VGmYgsoa6AzHSPeagEVoawdSlyFh7njYG2Z5P9BedX
        E4Cjon2GYV6shqrToVM4xM4=
X-Google-Smtp-Source: ABdhPJyDGcDcFSHABBXq0N86Iw0ZJluaX2DN9WQVwXKsSJSnR4pwTNT5RKte6PZ7ZwROV35l0Z/RAA==
X-Received: by 2002:aa7:c7c2:: with SMTP id o2mr36105122eds.166.1629707199676;
        Mon, 23 Aug 2021 01:26:39 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id d16sm8773785edu.8.2021.08.23.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 01:26:39 -0700 (PDT)
Date:   Mon, 23 Aug 2021 13:56:33 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Larry Finger' <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
Message-ID: <20210823082633.5bofcovr7bvtohde@xps.yggdrasil>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
 <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
 <05aafb94be1b4e609250313709cd668d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05aafb94be1b4e609250313709cd668d@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/22 09:30PM, David Laight wrote:
> Modulo anything that really means it should get_unaligned_be32().
> 
> 	David

Thanks for your reviews David!
Will make this change!

Thanks,
Aakash Hemadri
