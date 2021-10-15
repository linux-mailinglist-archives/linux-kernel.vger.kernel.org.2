Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5948142FE19
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhJOW3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJOW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:29:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39001C061570;
        Fri, 15 Oct 2021 15:27:22 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so14744376otb.10;
        Fri, 15 Oct 2021 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9aeUe4ZI4jBbqIbND7LhOYrt/dpCCzqy4kzXucAAhcE=;
        b=nu+wkVrTUYsdrakwbebwUqGS3MNnezxKmYAFGZRflHzIDv4e1KxmpDog4u7molTrK9
         6WKS5dTeNSohwgVwXkaR2QG0jdGbbz06HgPdKx2v8mTUQu/JFfIjIPLWuzp+sf3+nlZb
         DLPAuq2JM127wzua+aM8B/qi2zzKwc56YuzZNNUadhxJSZynZih34GfZM+j+zW8FBEp7
         MTBoXzqdLnKA6F5Wb/0CcbNsql6c6yG+78o8Pbelwnpwb91AnKUA/56MnB7RJYGtlpZp
         QptPmNIE4ReLlptl81+O0vaF41B+kJJgVikLdaQyASbIHcTk2MMD4gJzzbd3Top/LvhV
         KLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9aeUe4ZI4jBbqIbND7LhOYrt/dpCCzqy4kzXucAAhcE=;
        b=iMfTnRCEudb9H7kitEQkxcWhBotmCzHbK91mjRMl9kTYDFBWjEdEPU/OJ4LF3u/rRb
         ghVHcgyedvnaNU1eCOVntDAGl8Z8XA12j9wkdw5DDJa0pMBW4t1w8AWKmfhSwh/T/jFN
         npKUvhPMfFw1voolbixQxkh6pul7MwX5rwYILviF81pHYEcwTkjcyFq/nKtnykvKfq13
         JjJF+4f1bJSa1lMy2JKdPaVQYjjssu6A0kfcknlm2+76xVFn74FCKIONomuh2ueTyIm2
         JiFovDLdXjZRKu2i57gp4gsi1EiW+N/77veK9/UdfMH5hcmAFcwgp3FSzGuee7VjQvMX
         Ck4w==
X-Gm-Message-State: AOAM531XGxHmDCCqhXmoC6sGvd216g7WK2ch+/84hXbjELPAlUc+nNRo
        octqfA/HTjTyh3VXX9D1C7l+gmXcgjY=
X-Google-Smtp-Source: ABdhPJwfdfOvdT+Uk8C/mzN/PAp7SrOCk9JWuOEeK8ce5Me9U/dKD2fV5CZdgjrtHJzOdTvsHbdqDg==
X-Received: by 2002:a9d:655a:: with SMTP id q26mr10184755otl.130.1634336841603;
        Fri, 15 Oct 2021 15:27:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4sm1471848oia.56.2021.10.15.15.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:27:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Oct 2021 15:27:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Wilson, David T. (GSFC-5870)" <david.wilson@nasa.gov>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: Potential issue with smb word operations for tmp461 device in
 tmp401 driver
Message-ID: <20211015222719.GG1480361@roeck-us.net>
References: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR09MB7440BF952778F0DB8138747DE7B99@SA1PR09MB7440.namprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 15, 2021 at 05:43:54PM +0000, Wilson, David T. (GSFC-5870) wrote:
> Hi,
> 
> I am reporting what I believe is a potential issue in the tmp401 driver for the tmp461 device specifically. I am new to reporting issues, so I apologize in advance if I've provided insufficient information for an issue report.
> 
> The problem I'm encountering is that when I use the tmp401 linux driver to read temperature values from the tmp461, all of the read temperature values end with 996 (e.g. 33996, 38996, etc...).
> 
> Looking further into the tmp401 commit messages, I see that the driver was changed to use smb word operations instead of separate byte operations. Although the other supported devices (i.e. tmp432, etc...) are noted to support 16-bit read operations in their respective datasheets, I see no indications of 16-bit read support in the tmp461 datasheet, which is supported by my inquiry in the TI forums (https://e2e.ti.com/support/sensors-group/sensors/f/sensors-forum/1044935/tmp461-linux-driver-support-and-16-bit-temperature-register-reads).
> 
> Reverting the driver to the commit before the smb word change, I am then able to read temperature values that do not end only with 996. As a result, I believe that the tmp461 support may be partially broken by the switch to smb word operations.
> 

Thanks a lot for the report. Can you send me a register dump for the tmp461 ?

Thanks,
Guenter
