Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29E1412A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhIUBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhIUBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:33:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C158C128EEF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:54:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h17so65795222edj.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOeWGQccqNIO3Gt6IciB4/cPzEmqz/XqdZFiLVlEWq0=;
        b=bDrqRXrNNUauDRopz+n+sYeQFqZ+OvibCLkMNmaH1WxcRlq46RDtCsFdswnmuipmFP
         1zzzimMKzt3UC98fp9QL8tdvqFfJD9Xl5MbwWqLQ9RW7e+RfmHn3qyjWB0j8G9S2bxZe
         oQEYMDfq12DLkouVVKdGIT92jyLSdfxa0AajlS5WFS1UQxHicg+tfqbQWFgU8aQItq7x
         SeI3cnv2nBUqpKam4EookkUS1xtOL7A9CviwpZH4BCkevQ8wSfY1o2z3hSc937FefBDr
         vTF5xA1Sr+DULxBGRHuTogIUbWIWLhiLlCiwF+qbl5saE/lHMVwhDSgNKBs8F2wR350G
         eJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOeWGQccqNIO3Gt6IciB4/cPzEmqz/XqdZFiLVlEWq0=;
        b=frvySVyBf6bcf5TvQH4XQDfk9bvDaJyHBYXoj1ic8z4RStnXKemomtk0iWDxL/3U2Z
         hpVMuT/ROKBNoLGmbGOrvCO2IQmDn5BtWUr6eUrwZk+CN9ZIO/5VJt7uP0YxLw2CkD0d
         NnuLTW5aJE2kpTM3W7uoe36DUSmK4LcDlxLr9HV7H31FzuGcNoMT/1f5AXOxeWLc7OQm
         xru0dNIMt8ptn9pnR2nlCPV8CypcUPh3iYRee0VMNHT+IblYOPbpWm8G6oYDcT0n06DH
         VFIxIKwGyETe7KBS0oYxh+51wQG4TruBSHkLOy33ZvalBUs6bJ+EIcl7nMq2GK4TNPlZ
         03RQ==
X-Gm-Message-State: AOAM530/GB0tFha/xRjSYPHI2ikPPBIMWCoW/8o/KpX7NxABSMPEapHS
        j41uOrps5k5rYUUo1/QxhQI=
X-Google-Smtp-Source: ABdhPJzDGkAslpZRA4vTkrGCJmSSYSiU3d0sQK9NACOhYqiX9/7NX8AzJV2hVHYmy4UXIHPTlwTifg==
X-Received: by 2002:a17:907:2624:: with SMTP id aq4mr30819421ejc.448.1632167683247;
        Mon, 20 Sep 2021 12:54:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id g10sm6518271ejj.44.2021.09.20.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:54:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable in rtw_read16()
Date:   Mon, 20 Sep 2021 21:54:41 +0200
Message-ID: <2079638.AGfTBEE1WJ@localhost.localdomain>
In-Reply-To: <20210920190133.GS2116@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com> <3187315.KoBY3qX4Pt@localhost.localdomain> <20210920190133.GS2116@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 20, 2021 9:01:33 PM CEST Dan Carpenter wrote:
> On Mon, Sep 20, 2021 at 06:17:36PM +0200, Fabio M. De Francesco wrote:
> > On Monday, September 20, 2021 3:10:36 PM CEST Dan Carpenter wrote:

> > Back to the code... uninitialised data is not a problem in the old code, 
it's 
> > just bad design. The new code cannot affect runtime, it's just better 
design. 
> 
> It would be a problem for KMSan and the kbuild-bot will email you about
> it.  From your commit message "Change the type of "data" from __le32 to
> __le16." it's not clear you understand why the kbuild-bot will email you
> and why it's correct to do so.

I guess that for sure you are right in saying that it is not entirely clear 
why the kbuild-bot will email me. However, since the change is correct, but 
the commit message is not, I confirm that we'll use your note with only a 
slight change (only if you agree): replace KASan with KMSan in your text.

Thanks,

Fabio  
 
> regards,
> dan carpenter



