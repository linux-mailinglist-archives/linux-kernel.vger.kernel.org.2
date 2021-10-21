Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598FD436E29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhJUXTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhJUXTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:19:17 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AD2C061764;
        Thu, 21 Oct 2021 16:17:00 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id s2-20020a4ac102000000b002b722c09046so606666oop.2;
        Thu, 21 Oct 2021 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u6+HGv+IrKQ75C3lOP4JqNec0f2MGIeUfeYVO08vZgI=;
        b=GTt4fA5+j0rZSHq4ZUPC6OYecQ0Ug5r9xEbgDYNfqC7RE7vhAiwx7GkDrofFQQHHwS
         tJv7KLxGjFmQW1Ex8/lDACSoFeaztKVLDKM3ygko2509n8w/TFRMUho0pAEMpE1Xn5zA
         DACsbGeC76cYBOBpyNYJTZYCM4ChlF7XMOLMJDP8T+b8QaDtXdPZ9lzYqawxWoLXJk9c
         sSSglJs7ZWypcO4S72b7tF4iiJGCrrA8YDCrd51vl+o9Evc8FTsB3oK6L+kmrX3lP+cx
         mfY2S8VK2AfSmvvX3X5TLClnzSpOUqW7Ley/vRwEllwUw+0IUxq6bYVcetciNNraJ7pB
         6ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6+HGv+IrKQ75C3lOP4JqNec0f2MGIeUfeYVO08vZgI=;
        b=UAlG23E1jeaTGKpKw4yWIvmwgHmcogsHGhYNldJ8xev9ICNKMKqxtF2JwJGmiV7lU6
         cuULPGIV7B0I74VhAHsKhZToES/MTzXiKV7B+iCS5+L571qgVxM/2q+NlpIgqg7mohGw
         TVI0SgQgiiMPazLsw120G/62lrkn+9JdB7pPnNBvTBCcTqNq6H9sdPHj9eruqcWgrtvq
         wtIo8H4lE5VSaz0PWDHqgXfIHYKtCDTl0m+mJeAaYDu5ND5eanXw9ouz/QmBqLqHIcBh
         ofcj4Pt5w7CsLEn3JUljPTGLAbKTMwxtgOk50s1Cjf02kh6FZSRrhLeLC/cgsWVlOnwV
         7SkA==
X-Gm-Message-State: AOAM530AZ+yMJtHXoCcsgjtkUPo5co8CRPQCuacVr0xERD7hH0jy5wg4
        DvmCjOlCIOoVD/kn/kJe7yuw7Szg1Kc=
X-Google-Smtp-Source: ABdhPJwgR7RwPHg4OeNlgZT1UX3U5meCR6zGOIptqkgop9jpF8ES35IoZGIHvJycX6cUISLz/aeXSQ==
X-Received: by 2002:a4a:dc82:: with SMTP id g2mr6525764oou.97.1634858220246;
        Thu, 21 Oct 2021 16:17:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s206sm1414973oia.33.2021.10.21.16.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 16:16:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 4/4] hwmon: (occ) Provide the SBEFIFO FFDC in binary
 sysfs
To:     Joel Stanley <joel@jms.id.au>, Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Jean Delvare <jdelvare@suse.com>
References: <20211019205307.36946-1-eajames@linux.ibm.com>
 <20211019205307.36946-5-eajames@linux.ibm.com>
 <CACPK8Xdq-tzPddkCDFx7-BuYh-hReutiKD4Rax+Wxi4FKfDSow@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3661cc4a-832e-5570-02cc-4d89026ec11c@roeck-us.net>
Date:   Thu, 21 Oct 2021 16:16:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xdq-tzPddkCDFx7-BuYh-hReutiKD4Rax+Wxi4FKfDSow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 4:09 PM, Joel Stanley wrote:
> On Tue, 19 Oct 2021 at 20:53, Eddie James <eajames@linux.ibm.com> wrote:
>>
>> Save any FFDC provided by the OCC driver, and provide it to userspace
>> through a binary sysfs entry. Notify userspace pollers when there is an
>> error too.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter, I will merge this through the fsi tree unless you have objections.
> 

Go ahead.

Guenter

> Cheers,
> 
> Joel
> 
>> ---
>>   drivers/hwmon/occ/p9_sbe.c | 86 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
>> index 9709f2b9c052..e50243580269 100644
>> --- a/drivers/hwmon/occ/p9_sbe.c
>> +++ b/drivers/hwmon/occ/p9_sbe.c
>> @@ -4,18 +4,79 @@
>>   #include <linux/device.h>
>>   #include <linux/errno.h>
>>   #include <linux/fsi-occ.h>
>> +#include <linux/mm.h>
>>   #include <linux/module.h>
>> +#include <linux/mutex.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/string.h>
>> +#include <linux/sysfs.h>
>>
>>   #include "common.h"
>>
>>   struct p9_sbe_occ {
>>          struct occ occ;
>> +       bool sbe_error;
>> +       void *ffdc;
>> +       size_t ffdc_len;
>> +       size_t ffdc_size;
>> +       struct mutex sbe_error_lock;    /* lock access to ffdc data */
>>          struct device *sbe;
>>   };
>>
>>   #define to_p9_sbe_occ(x)       container_of((x), struct p9_sbe_occ, occ)
>>
>> +static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
>> +                        struct bin_attribute *battr, char *buf, loff_t pos,
>> +                        size_t count)
>> +{
>> +       ssize_t rc = 0;
>> +       struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
>> +       struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>> +
>> +       mutex_lock(&ctx->sbe_error_lock);
>> +       if (ctx->sbe_error) {
>> +               rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
>> +                                            ctx->ffdc_len);
>> +               if (pos >= ctx->ffdc_len)
>> +                       ctx->sbe_error = false;
>> +       }
>> +       mutex_unlock(&ctx->sbe_error_lock);
>> +
>> +       return rc;
>> +}
>> +static BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
>> +
>> +static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
>> +                                size_t resp_len)
>> +{
>> +       bool notify = false;
>> +
>> +       mutex_lock(&ctx->sbe_error_lock);
>> +       if (!ctx->sbe_error) {
>> +               if (resp_len > ctx->ffdc_size) {
>> +                       if (ctx->ffdc)
>> +                               kvfree(ctx->ffdc);
>> +                       ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
>> +                       if (!ctx->ffdc) {
>> +                               ctx->ffdc_len = 0;
>> +                               ctx->ffdc_size = 0;
>> +                               goto done;
>> +                       }
>> +
>> +                       ctx->ffdc_size = resp_len;
>> +               }
>> +
>> +               notify = true;
>> +               ctx->sbe_error = true;
>> +               ctx->ffdc_len = resp_len;
>> +               memcpy(ctx->ffdc, resp, resp_len);
>> +       }
>> +
>> +done:
>> +       mutex_unlock(&ctx->sbe_error_lock);
>> +       return notify;
>> +}
>> +
>>   static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>>   {
>>          struct occ_response *resp = &occ->resp;
>> @@ -24,8 +85,15 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
>>          int rc;
>>
>>          rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
>> -       if (rc < 0)
>> +       if (rc < 0) {
>> +               if (resp_len) {
>> +                       if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
>> +                               sysfs_notify(&occ->bus_dev->kobj, NULL,
>> +                                            bin_attr_ffdc.attr.name);
>> +               }
>> +
>>                  return rc;
>> +       }
>>
>>          switch (resp->return_status) {
>>          case OCC_RESP_CMD_IN_PRG:
>> @@ -65,6 +133,8 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>>          if (!ctx)
>>                  return -ENOMEM;
>>
>> +       mutex_init(&ctx->sbe_error_lock);
>> +
>>          ctx->sbe = pdev->dev.parent;
>>          occ = &ctx->occ;
>>          occ->bus_dev = &pdev->dev;
>> @@ -78,6 +148,15 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
>>          if (rc == -ESHUTDOWN)
>>                  rc = -ENODEV;   /* Host is shutdown, don't spew errors */
>>
>> +       if (!rc) {
>> +               rc = device_create_bin_file(occ->bus_dev, &bin_attr_ffdc);
>> +               if (rc) {
>> +                       dev_warn(occ->bus_dev,
>> +                                "failed to create SBE error ffdc file\n");
>> +                       rc = 0;
>> +               }
>> +       }
>> +
>>          return rc;
>>   }
>>
>> @@ -86,9 +165,14 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>>          struct occ *occ = platform_get_drvdata(pdev);
>>          struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
>>
>> +       device_remove_bin_file(occ->bus_dev, &bin_attr_ffdc);
>> +
>>          ctx->sbe = NULL;
>>          occ_shutdown(occ);
>>
>> +       if (ctx->ffdc)
>> +               kvfree(ctx->ffdc);
>> +
>>          return 0;
>>   }
>>
>> --
>> 2.27.0
>>

