Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A95393438
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhE0QoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233038AbhE0QoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622133751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vTNhbBtiHXqAd12PS1yesU25XwiD0QzTA7/TTPBmFM=;
        b=Cin0ejD/89HPjFZ5dMvuDEsXKxO63ZDCqSRog2NBFVZUB/Rd7N15fhA6tT2gshvfOVk28j
        BfrEBITg9PAd9vP/SifjtWwJb2/bi9zrBqKs1oNHkiNzab1fT/fOSlQq0ju7vA+O5TWtnl
        s8D9gzpiWRAGKmX/Ge7qgozKdqsO93k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-wO8zjWocOLavHcQuHWDamQ-1; Thu, 27 May 2021 12:42:28 -0400
X-MC-Unique: wO8zjWocOLavHcQuHWDamQ-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cfb029017cc4b1e9faso1689751wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 09:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2vTNhbBtiHXqAd12PS1yesU25XwiD0QzTA7/TTPBmFM=;
        b=Gh+8dg9RQSEhdCfZqpsuFhBcKw3ING1SPeCQTnAKQ1M3D23/vqQjomsaof/Pj+KLAk
         Ex+BdUZ//b4bR8YeI5pCIE6i9q85Gm7AAHbuiok8Bp3t6U1FPTKXAW0H4xjKe0oENDCf
         s1CNkTH7vUdlIXa9gCxFDQnwVA29bnuwonH/mTim8Eja8HGX5/EzadkR2hBV6CSBsWi0
         ty5hJkN46CNF1iJ7598i/6dqixACzvlUfwAWbGBqKbuy0LnRBjtqONVKGVaSlE8EMEbN
         CgK5/0qBdWeAvnLpnAFcfjkLNJ9c6smBg9+kT4rpcnn1yBUUDS+dD6eoXY7j2O31rOh5
         7oBA==
X-Gm-Message-State: AOAM531x0R8LDm72ZspNUdVZTd+pQmetpwiSh8W4N6pMlD8P5ZYBmlhg
        39V4t4ku8qc8Kl/6B9CyHE/h/Ty2K3BlGRKm6ETfHX1SbT8cqmwju9R0DOmVxLoNCzyfKw6NtR7
        0jCP35YGE0Oi5hSWKRKGkY+8q
X-Received: by 2002:a1c:b0c2:: with SMTP id z185mr3256688wme.38.1622133747662;
        Thu, 27 May 2021 09:42:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd/dStGoMEo6c95w85TOJyRiGeyA9gUUPIcnxY9CuuEd6+4PjtLVWZVfzTgdoS1B5uDDe0hg==
X-Received: by 2002:a1c:b0c2:: with SMTP id z185mr3256668wme.38.1622133747375;
        Thu, 27 May 2021 09:42:27 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id l16sm12551203wmj.47.2021.05.27.09.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 09:42:26 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis_spi: add missing SPI device ID entries
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210527152352.3835076-1-javierm@redhat.com>
 <20210527161156.GH1096940@ziepe.ca>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <f0afae88-419f-6792-c795-b15e724ba739@redhat.com>
Date:   Thu, 27 May 2021 18:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527161156.GH1096940@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jason,

On 5/27/21 6:11 PM, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 05:23:52PM +0200, Javier Martinez Canillas wrote:
>> The SPI core always reports a "MODALIAS=spi:<foo>", even if the device was
>> registered via OF. This means that this module won't auto-load if a DT has
>> for example has a node with a compatible "infineon,slb9670" string.
> 
> Really? Then why do we have of_tis_spi_match and why does spi have an
> of_match_table?
>

It's correctly used to match drivers with devices registered by OF, so it
makes sense to have them. It's only the MODALIAS uevent reporting in the
SPI core that doesn't do the correct thing:

  static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
  {
	  const struct spi_device		*spi = to_spi_device(dev);
	  int rc;

	  rc = acpi_device_uevent_modalias(dev, env);
	  if (rc != -ENODEV)
		return rc;

	  return add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
  }

where spi->modalias contain the device portion of the compatible string in
the DT node.

Now compare with what the I2C subsystem does for example:

  static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
  {
	  struct i2c_client *client = to_i2c_client(dev);
	  int rc;

	  rc = of_device_uevent_modalias(dev, env);
	  if (rc != -ENODEV)
		  return rc;

	  rc = acpi_device_uevent_modalias(dev, env);
	  if (rc != -ENODEV)
		  return rc;

	  return add_uevent_var(env, "MODALIAS=%s%s", I2C_MODULE_PREFIX, client->name);
  }

Fixing the spi_uevent() function would be pretty trivial but that would break
all the drivers and platforms that are relying on the current behaviour.

So until we have fixed all the SPI drivers and make sure that have a proper OF
device ID table to match against the reported OF modalises, we will need to add
these workarounds to the SPI drivers.

It's true that we could get rid of the OF device ID tables in the SPI drivers,
but that would mean that:

a) The manufacturer portion of the compatible string would never be used to
   match a device to a driver, so "foo,bar" and "baz,bar" could match to the
   wrong driver.

b) We will be even more far from eventually fix the SPI core modalias reporting
   since SPI drivers won't have OF aliases in their modules.

> Jason
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

