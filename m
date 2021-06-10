Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C833A2F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhFJPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhFJPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:42:43 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF761C061760;
        Thu, 10 Jun 2021 08:40:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u11so2576863oiv.1;
        Thu, 10 Jun 2021 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=femDuYUXuqruOqx2TsnJZ+aLFaWLNFefSVqnRCuu/Zs=;
        b=fxoEBBlSKht7mMd03uvm8OLc9SNR1R/Xu/NJg0ug7QjPztOHliUIjc7+01lt6y1evM
         P5lPo1Ym4BBzZ2XGqBGaX3KEWj+DvKZa3akWaMLPI+yfOyvWFBJLL8KeBqZcHYcgCyz7
         gMzePQeAOJz1tduugd9J0liEqseBRyjHXQQFDSKWgAVBnUez4SiJ8hEly1KVf/GK9DjA
         JnDNvLrGFala4UWZmTNbEsC8CdgOH9B5aktDhlUUNjsIZSjv9GOKHY/7IEavYnFeTDCl
         6j6EAI3U/9xOba5GxPSjKqYnaMk+GZ5tYBAf/YsRKOemXtj2QToRLHcbaWCRpXZkjpIl
         6s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=femDuYUXuqruOqx2TsnJZ+aLFaWLNFefSVqnRCuu/Zs=;
        b=rzI1FDKk2xPDk5Q8wIikrkGDPcEfXZrFRBqVS9x8VnBk5QxO27On8OpUGNB4xVcOSj
         cveFxAyIxWnvmivwWxxI5aZmXqiCycSl2HhLszsx7IrYJVg9LSPdj7ka4v/SNEFYuC2V
         NlCrEVEUdRATz9HssdqfIqnCnPnuJANCZqI/ro8BIgSDyaXx6SUzO+BLJGiXU/FAhEzP
         rxQ2Qj9+mJfqFaXuTJ2C7q+3ME92QFxnHcQP68YHMbNdLy1stXWpCriRX2URuTUpwNvh
         YladQnWmmGrjj2VvYkTThp2pSxvvP1yEhzaD02KO1WqiDkUJMkQz2YMjZscdvcieIJVw
         6t7Q==
X-Gm-Message-State: AOAM532IqiigupkJx97PZL/9Xa8fJb664LPoAcWGOdrQYajmNFAttMTn
        w7CNd3EZYG+DkqdwFUYfsCg=
X-Google-Smtp-Source: ABdhPJzzaheB698nR9MkmUxkaIRuCklDdkjZ69QhLYuQaaVqejJkkodVoeE8czWPimPsUHzbNQtjBg==
X-Received: by 2002:aca:b906:: with SMTP id j6mr388730oif.40.1623339630351;
        Thu, 10 Jun 2021 08:40:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26sm669073otq.43.2021.06.10.08.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:40:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Jun 2021 08:40:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH 3/3] hwmon: (tps23861) correct shunt LSB values
Message-ID: <20210610154028.GA3859122@roeck-us.net>
References: <20210609220728.499879-1-robert.marko@sartura.hr>
 <20210609220728.499879-3-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609220728.499879-3-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:07:28AM +0200, Robert Marko wrote:
> Current shunt LSB values got reversed during in the
> original driver commit.
> 
> So, correct the current shunt LSB values according to
> the datasheet.
> 
> This caused reading slightly skewed current values.
> 
> Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Applied.

Thanks,
Guenter
