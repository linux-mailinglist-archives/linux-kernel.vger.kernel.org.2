Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB54C3F1409
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhHSHKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhHSHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:10:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB94C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:09:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j187so4620277pfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mijRCYJWhiNYKUcggEieBjK/IJfHCFKEgd0FRoEC7LM=;
        b=cqgCRQ1U6V4JJ4tcDdUV6PMZNDJO6XuUV6fP/t3dh/cJalqPpz+xCy/06fBvpomlAl
         UZF6lSZHstctDQGwsKhCOgxp7IHejOGO/QJVoL1C8pDygvtuMGpPKEFlULUpR3/sY9Ms
         oz4aGL1Mw1EONt2nEtsSg0dAWr9nqJfC0EEAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mijRCYJWhiNYKUcggEieBjK/IJfHCFKEgd0FRoEC7LM=;
        b=AZamFJ20LxPTSOfxGfNRQLP/3x5gbH6p2GizXMp+sPwM2FhIV0B6uWt+G6hv0MP9Lg
         3bT0/UcBCgHJGKVRcqMyH9aFDWIL9OCvHwzaS28mkVV9eI4wZ3On8GvUCkyvT6WN+DOZ
         7W7mkSPGEUj1pVvr9F8i99kvPQQWBbEtr0qqfGzTx3gOTMQmGlwav1mBc1iBXTcfwK17
         gkI+eAydv2FK1i77HL+NF1rpMFR6jqVQp7flNIaUZ7NfNlkIZqKDmSjzLvcY24hvac/Y
         SSSHL04zqV02tmm7lhYO7AhGCBDHTzzr5gp17nbUHKm7QvYzzQR3sLLRdonPUp/68OwP
         MWgA==
X-Gm-Message-State: AOAM5338dCznQirRHrm1i3S9G9MJnzzOZMDloLo04na8zdad6zYAHC4Z
        +nQlKQFN/UfzR1Rcyx3a8ZqhtQ==
X-Google-Smtp-Source: ABdhPJxImLZctpQIjKmcj34VRkZg/VYmBXTz1xVTM1Ta1cbYQsomWRTwQxx74j2ybW2hZ502i4sO3g==
X-Received: by 2002:a05:6a00:10cf:b0:3e1:d742:ad81 with SMTP id d15-20020a056a0010cf00b003e1d742ad81mr13283518pfu.29.1629356967408;
        Thu, 19 Aug 2021 00:09:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm1987947pfc.214.2021.08.19.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 00:09:26 -0700 (PDT)
Date:   Thu, 19 Aug 2021 00:09:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Kevin Mitchell <kevmitch@arista.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] lkdtm: update block layer crashpoints
Message-ID: <202108190008.2BBB6B68F@keescook>
References: <20210819022940.561875-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819022940.561875-1-kevmitch@arista.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

You weren't explicitly in the To: for this series (only Cc), but are
you able to pick these up as well? I can resend them as a pull request
if you need.

Thanks!

-Kees

On Wed, Aug 18, 2021 at 07:29:38PM -0700, Kevin Mitchell wrote:
> This is v2 of https://lkml.org/lkml/2021/8/16/1497.
> 
> These patches update the lkdtm crashpoints in the block layer that have been
> moved or removed.  In response to feedback, I've renamed the SCSI_DISPATCH_CMD
> crashpoint to SCSI_QUEUE_RQ to correspond to the new function that it hooks
> into. I have also added a commit to remove IDE_CORE_CP.
> 
> 

-- 
Kees Cook
