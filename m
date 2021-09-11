Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB8407AAA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhIKW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 18:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 18:26:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ADCC061574;
        Sat, 11 Sep 2021 15:24:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ho42so12035655ejc.9;
        Sat, 11 Sep 2021 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKgPzy/67n6BT3xHjjT0ui5Gqa0qr/xXiXCBRQ1Nyf8=;
        b=Ia91sqZ2JrabhXZ4LCNaeUf3uovXznKabEQ4kOrTKXiz1QNzwULL/mhKU0/b9hnvCa
         IAbeUY5bHGY64PGWxP7LlIZW6DqZG8vGi6kIA/F0q2gLY7kYi2dgbAg6RC+LRi+z49Y/
         e2Kmn/AMQpwJmBbChUNDxDRVXKAePW+ifILCgXO+JMmDiG20ILxj3vacHT0UrrENYG5s
         /fJFPkfhZUgUf/AAzIJY9fwHS2FYDbhTXsNohhD/QVZUTv0RG5RY7L1X/e40AcX4xflb
         UTd0H8VUTbgyJIKFw/vogB/U9UqM/mtAeT+9d5/wDqmKYVTYJriGAWrx8/Xw+7VsxBmW
         C0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKgPzy/67n6BT3xHjjT0ui5Gqa0qr/xXiXCBRQ1Nyf8=;
        b=7ttnMpi7QCz9BSMHfGcT4C/DGXUOugRhokT3iWgWd8/k/y6l75d3pEJ2H3roScAzHP
         GIy4J9LD/rOrTOI0DlSQJM2e0m+7hcrBKpfwo104CxHFSVRP8Q8y2iyfeRCPYjTTzjBL
         DjbGT7wqdFxyIWL+KweNdfc76EeIdYrFuPIgPRF6cDt0Ca77EoF/DaPJmDGrKobZ2tFA
         oqN7vw7mekN2WGhS9W3ac3JnR0amlln+eJmUWB7s9R5I2SlUahI1O83nlikqoOqswOVB
         sN9pFiVmomh3VcVc0Ifn8j+ORCHvmJ4iPL2l7jEkiSzCwbIgr26zzm7r5pjoVQA4UitE
         JS0A==
X-Gm-Message-State: AOAM530/JcOrrjwA8UgHrgkwmz/CGP2JE5gY4+W1OPRg/EmLFzQ0QNTr
        wtjJwJBFOdB6SxWxhIWAcAI=
X-Google-Smtp-Source: ABdhPJyeRGGM78H7dl9lFz+0f9yopOjKuNICK/14ylAPdI5OSnN//hulBog9p0YZFdAunsl9WFgpww==
X-Received: by 2002:a17:906:39cb:: with SMTP id i11mr3644119eje.168.1631399096748;
        Sat, 11 Sep 2021 15:24:56 -0700 (PDT)
Received: from penguin.lxd (151-22-179-94.pool.ukrtel.net. [94.179.22.151])
        by smtp.gmail.com with ESMTPSA id z15sm1481230edr.80.2021.09.11.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 15:24:56 -0700 (PDT)
Date:   Sun, 12 Sep 2021 01:24:51 +0300
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (nct6775) Use sio_data in superio_* (v2)
Message-ID: <20210912012451.60a8ef04@penguin.lxd>
In-Reply-To: <YTo7OnzCRDZuveHN@smile.fi.intel.com>
References: <08262b12-4345-76a9-87be-66d630af3a59@roeck-us.net>
        <20210908213605.9929-1-pauk.denis@gmail.com>
        <YTo7OnzCRDZuveHN@smile.fi.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback!

On Thu, 9 Sep 2021 19:50:02 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Sep 09, 2021 at 12:36:02AM +0300, Denis Pauk wrote:
> 
> Thanks for your contribution!
> My comments below.
> 
> > Rearrange code for directly use struct nct6775_sio_data in superio_*
> > functions  
> 
> Missed period.
> 
> We refer to the functions as superio_*().
> 
> The commit message may need more elaboration (why you are doing this).
> 
> > v2: split changes to separate patches  
> 
> This should go after '---' (cutter) line below. But entire series
> needs: 1) a proper versioning (use `git format-patch -v<n> ...`)
> 2) to NOT be a continuation of the previous one (start a new thread!)
> 3) to have a cover letter (use `git format-patch --cover-letter`)
> 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807  
> 
> BugLink
> 
> > Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> > Signed-off-by: Denis Pauk <pauk.denis@gmail.com>  
> 
> This is wrong. My understanding that you have to preserve Bernhard's
> authorship and add yourself as Co-developer (see Submitting Patches on
> how to properly use tags).
> 
> ...


Should it be such ?

----
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-Developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
----


> 
> > +struct nct6775_sio_data {  
> 
> > +	int sioreg;  
> 
> It should be unsigned short.
> 
> > +	enum kinds kind;
> > +};  
> 

Should I change all occurrences of sioreg to unsigned short?
Before my patch it was integer. 

--
Best regards,
                  Denis.
