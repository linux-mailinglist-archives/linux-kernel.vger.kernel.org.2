Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBF0311A55
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhBFDkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBFCcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:10 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C65EC033277
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 17:34:47 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w20so6476743qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 17:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c7NsMFWXAbgJrmq9lbz3I8y5eHU0q144DUn20NC1IKM=;
        b=S6lPx0SS3gQhH9rOWQ3D1LjhODu9VO1k55A0kHM/22O0snqF1jdNmNMGjlNzwHZLgD
         vFyBs32wFEHTad3DyxAGhsm8gQLuawarOU0WTLl+UipgeIjwSDv6TVWCUPH/Lw1jp+a3
         gN82dNS5S9O304HF3nX7cJ+IXmpXv8Q4jIGz1lpMLbMP6L9PmzsO6852PuRAZG9rNEof
         RiIIHLBoegN2nKddlYut0HJdR9tXs9kbr8rLQhtOytQH39oe6dgQfw/8QxsfOkiyomTo
         F2RpFdpGhBiswJlhz8Nilo2rqSzY2/WzGttNFeqqQSzlfPovrfpTCdBmJJJClwKux4Zg
         nH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c7NsMFWXAbgJrmq9lbz3I8y5eHU0q144DUn20NC1IKM=;
        b=UdpCDt6Bh5d/Hf99SOf+VMolb956DVf/Kzv5M32A0Ol+KdWtTQATkSp1NAnPyWiifk
         A8Vk51eHJXTrZTW0tV6NQ69XgwYblu6W2JonR2pyBavB6KAPndT/lRhG8A4gpe7gzVMM
         XrYbZXtNoW9H02Y5UW7bCv8gj5kiEaw8IBpdP4qj2kQvo7IlkDMwiYsr8bguI4MDpScj
         THKStvr+TMqG9cYQjjhqTWPCjjdpLudW4ks9cFWbphpeTAvSu3rHmLLJXzi3rE+cFLHX
         AFMuVRxtGoLwKEaFKVWc1gXgKox5mm1+H/yvYX276Bef5KZK+7ynnRtOproTqRvFhB6K
         Gwog==
X-Gm-Message-State: AOAM532iCApaF9jEzDKv1Q4lJ5apd+c1TKt4WHsZPOm9ApjMTUChHLOZ
        2IjHCyAqD965BSRoU/+ywqoydA==
X-Google-Smtp-Source: ABdhPJx3sZsgyk2yV7Jx4MdCmCOEhMkkdvrKYS4rfl3u8AjlIruFaP2f3E0v4TUIOkEKT6IHgmed7w==
X-Received: by 2002:aed:2f86:: with SMTP id m6mr6780191qtd.253.1612575286679;
        Fri, 05 Feb 2021 17:34:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id i15sm11480451qka.103.2021.02.05.17.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 17:34:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l8CUn-004C5U-9w; Fri, 05 Feb 2021 21:34:45 -0400
Date:   Fri, 5 Feb 2021 21:34:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        stefanb@linux.vnet.ibm.com, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v3 2/2] tpm: in tpm2_del_space check if ops pointer is
 still valid
Message-ID: <20210206013445.GT4718@ziepe.ca>
References: <1612482643-11796-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612482643-11796-3-git-send-email-LinoSanfilippo@gmx.de>
 <7308e5e9f51501bd92cced8f28ff6130c976b3ed.camel@HansenPartnership.com>
 <YByrCnswkIlz1w1t@kernel.org>
 <ee4adfbb99273e1bdceca210bc1fa5f16a50c415.camel@HansenPartnership.com>
 <20210205172528.GP4718@ziepe.ca>
 <525fe9047ffd66e0c8635c7d65e91943eb71cd6a.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525fe9047ffd66e0c8635c7d65e91943eb71cd6a.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:08:20PM -0800, James Bottomley wrote:
 
> Effectively all of this shuffles the tpmrm device allocation from
> chip_alloc to chip_add ... I'm not averse to this but it does mean we
> can suffer allocation failures now in the add routine and it makes
> error handling a bit more complex.  

We already have to handle failures here, so this doesn't seem any
worse (and the existing error handling looked wrong, I fixed it)

> >  		rc = cdev_device_add(&chip->cdevs, &chip->devs);
> >  		if (rc) {
> >  			dev_err(&chip->devs,
> >  				"unable to cdev_device_add() %s, major
> > %d, minor %d, err=%d\n",
> >  				dev_name(&chip->devs), MAJOR(chip-
> > >devs.devt),
> >  				MINOR(chip->devs.devt), rc);
> > -			return rc;
> > +			goto out_put_devs;
> >  		}
> >  	}
> >  
> > @@ -460,6 +459,10 @@ static int tpm_add_char_device(struct tpm_chip
> > *chip)
> >  	idr_replace(&dev_nums_idr, chip, chip->dev_num);
> >  	mutex_unlock(&idr_lock);
> >  
> > +out_put_devs:
> > +	put_device(&chip->devs);
> 
> I think there should be a if (chip->flags & TPM_CHIP_FLAG_TPM2) here.
> 
> I realise you got everything semantically correct and you only ever go
> to this label from somewhere that already has the check, but guess what
> will happen when the bot rewriters get hold of this ...

Makes sense
 
> > +out_del_dev:
> > +	cdev_device_del(&chip->cdev);
> >  	return rc;
> >  }
> >  
> > @@ -640,8 +643,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
> >  	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> >  		hwrng_unregister(&chip->hwrng);
> >  	tpm_bios_log_teardown(chip);
> > -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> >  		cdev_device_del(&chip->cdevs, &chip->devs);
> > +		put_device(&chip->devs);
> > +	}
> >  	tpm_del_char_device(chip);
> 
> Actually, I think you want to go further here.  If there's a 
> 
> put_device(&chips->dev)
>
> as the last statement (or moved into tpm_del_char_device) we should
> now

The proper TPM driver remove sequence is:

remove()
{
   /* Upon return the core guarentees no driver callback is running or
    * will ever run again */
   tpm_chip_unregister()

   // Safe to do this because nothing will now use the HW resources
   free_irq(chip->XXX)
   unmap_memory(chip->YYY)

   // Now we are done with the memory
   put_device(&chip-dev);
}

ie the general driver design should expect the chip memory to continue
to exist after unregister because it will need to refer to it to
destroy any driver resources.

> have no active reference on the devices from the kernel and we can
> eliminate the 
>
> 	rc = devm_add_action_or_reset(pdev,
> 				      (void (*)(void *)) put_device,
> 				      &chip->dev);

This devm exists because adding the put_device to the error unwinds of
every driver probe function was too daunting. It can be removed only
if someone goes and updates every driver to correctly error-unwind
tpm_chip_alloc() with put_device() in the driver probe function.

Jason
