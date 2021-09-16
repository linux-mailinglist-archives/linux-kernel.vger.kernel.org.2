Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7A40DB33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhIPN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbhIPN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:29:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84AFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:28:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h17so16828098edj.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doZM2TIQ3sjpALd6Z7h1VFOT7OfiEaaF9Rf0rCfAyto=;
        b=OjQQFk8y+gC45AGlup0Mco9jzBnPlMQvAt/BgMasKuA7fxTy2UUf6HXsq21cwQnNDq
         zY3KZGFqV60BhwrM3FC3LWEtn3oGaixHL9AnrtqrH5ipw6S5UZNi3nSDNqTUunLFbd20
         YbGC/Z8uAjP/lt9i3nXnJ8YdfgE1gXTGmT/vFILcKRLH/5wAV3wdBDpF13eerbWxtANP
         CxvOilHYVMw8OVoPpl1kwv/eKjEhB95ibBtAOIaMo1w7gIhn4CGEUxcRhdovA0/MVfgN
         uBu4H7vYjnl5MCW/6kbSv5S8PHZGrc+/Q0pteZQMX7Qs19aweFtMCa3byGmi0RSCw5Ka
         N5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doZM2TIQ3sjpALd6Z7h1VFOT7OfiEaaF9Rf0rCfAyto=;
        b=QHeTDZrunYF/yx7266w6pz9wuqsiE6O5PrsenG+wLtKKodHjsC4AdG229Wg9JFdoVD
         84FCecDIFv7nCesp1ie2uImQ0EHhEXPnWcJcCLeclYu+yOJrHgtSogHWn2g9AOPXQlCg
         ZJ4xXbOkfy9vvh1QzGFGo42t9qVG78LRZ3zuuT1+v3TdnPy1+xfaJKS7X54oH8RNceC/
         89/6FHaq1WTqQkAtr5DEPv+E5+1uA0tjRIRzo/anBjAmE1H2rs5TXiCOKRBejIczTOSs
         sIhGB3u4P3zLavRrQsY7JAgkKEV+4ehazEAk8eGsQ2JSBSO16s04FQQvbrZ6GcT4Hc8b
         uhBQ==
X-Gm-Message-State: AOAM533pSvVK/DkRYVNVumwlpV1PhSqDOF1wGJ9vish0LXW9/4VLt8d1
        sHGg6+R28JQRb8+KIBUN104=
X-Google-Smtp-Source: ABdhPJzNGqsOlP8FNyJxYLKNRkeDEaIU8dXyNil/vvYEgeehUyk4ZpCbBcDaNyeqXmuU+Y3BYBh83Q==
X-Received: by 2002:a17:906:2a0a:: with SMTP id j10mr6201020eje.103.1631798915380;
        Thu, 16 Sep 2021 06:28:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id dm8sm1398996edb.90.2021.09.16.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:28:34 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v6 14/19] staging: remove struct _io_ops
Date:   Thu, 16 Sep 2021 15:28:32 +0200
Message-ID: <14709143.SPC8MWreAs@localhost.localdomain>
In-Reply-To: <20210916125200.GM2116@kadam>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com> <20210915211103.18001-15-fmdefrancesco@gmail.com> <20210916125200.GM2116@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2021 2:52:00 PM CEST Dan Carpenter wrote:
> Patches 1-14 are great.  Those 14 patches are:
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
Dear Dan,

Thank you very much for your "Reviewed-by:" tag. We really appreciated it. 
And thanks for the suggestions you gave about the other 5 patches. v7 will be 
made according to them.

As far as it regards to 1-14, I want to point out that the bulk of the work  
was done by Pavel (all the coding). Of course we discussed the general design 
of the 19 patches together, but for the first 14 I just wrote the commit 
messages and subjects and obviously I also reviewed and tested them.

Regards,

Fabio



