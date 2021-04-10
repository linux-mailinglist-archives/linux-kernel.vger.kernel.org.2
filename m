Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DAA35AC87
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhDJJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhDJJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:45:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5963FC061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:45:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g5so5666178ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=moesTed4SVvjaNssZNC/2a+G5e9IgTbR1YQQGq/nOzU=;
        b=MWRDyMOnBOY9P85izdF6hnKFStsJyXxJ9F/MYorK3rfWvKQ+wJXuUxkBEBwL02H3jE
         wa++ClxVuTMr+B+zcOVFWZAcfcGP21+VWc8xH31dXXK6+7drtQDapNjBwedSMDXkRWkB
         XaitJhrrtRVDE2xGmYOfpA4TTalHHFEggMa/9OfI98KaIQDB/5v2OUitWBYjMbMlansU
         VumQiVl8Wr6Wfkb7Zkkqo5HQXZV31HHpP+K19cRk5YwQo+DpzN6XL6WGqeGsMKBRlg9z
         Qw9koEAffMF1fhc0l+w0shxSlZCyGB8XEwTyvQvf3tw1PAcBeMYlDmtRMDzHMGMKKslf
         OE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moesTed4SVvjaNssZNC/2a+G5e9IgTbR1YQQGq/nOzU=;
        b=ZqZRhoVPVW95inSDBOzG4XUR3166XpoMXxmgxSmDsk39kqjyFqR3yLBy1/+hROcN6g
         VHuGfnFW+MnSZCRWavKUZcqyXH2gg2k7rrefY1vmGxqomgcKJtRojbgT19BvcrhkK0JB
         q5ZV60POw4J5knMQdueoI9zkY5Z1NXHczvkaT+HY6RxNRxqgD2sOcBaHho1uvPl9Rcn1
         xfo8DkfmNusP59pWCyfWfvhTmcVcOxof6hfw83lfNhJ/qzB5Fg7x87bKYsz+VTnkQbeG
         SRvJiliugn7P74vvGyBNDiGbNAump54NJ2CMCP4xbdswXjOd74rgk9T2+eBrId7t6TlW
         dk5Q==
X-Gm-Message-State: AOAM532ci627f2g8GeOlzD3t8hWkH2bw6OcfzJMZ5YYvzPaeG4fxj7/U
        Gk3sYXpLafb3D6DuwGXYt60=
X-Google-Smtp-Source: ABdhPJz1b2YxObuf6ixc8ARr8196K5I+q7NVJqfPK2KTgGRDUDS8KdYIDasUAwFQZEcLa4h/7ug0mA==
X-Received: by 2002:a17:906:5413:: with SMTP id q19mr721766ejo.8.1618047920066;
        Sat, 10 Apr 2021 02:45:20 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id j1sm2434983ejt.18.2021.04.10.02.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 02:45:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v7 1/3] staging: rtl8723bs: Remove camelcase in several files
Date:   Sat, 10 Apr 2021 11:45:18 +0200
Message-ID: <3026831.3QyE5GyAct@localhost.localdomain>
In-Reply-To: <YHFwkJlTNxQwPyN3@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com> <20210410092232.15155-2-fmdefrancesco@gmail.com> <YHFwkJlTNxQwPyN3@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 10, 2021 11:32:00 AM CEST Greg KH wrote:
> On Sat, Apr 10, 2021 at 11:22:29AM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase in bFwCurrentInPSMode, a variable used by code
> > of several subdirectories/files of the driver. Issue detected by
> > checkpatch.pl. Delete the unnecessary "b" (that stands for "byte") from
> > the beginning of the name.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> 
> Why is there a "v7" in this subject line, but not all the other lines?
> 

It's v7 because only this file (and not the others in the series had six 
previous versions that you dropped. Please remind that it was already sent 
alone (not in a series) several times. The changelog is in the body.

Should I drop that "v7" and the changelog, and the send the patch series 
anew?

Please, I'm waiting your instructions on what to do.

Thanks,

Fabio
>
> It should be in all of them, including the 0/X email, git format-patch
> will create it automatically if you tell it to.
> 
> thanks,
> 
> greg k-h




