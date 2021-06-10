Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E63A31DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhFJRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:18:29 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:46659 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:18:27 -0400
Received: by mail-pf1-f170.google.com with SMTP id u126so2157703pfu.13;
        Thu, 10 Jun 2021 10:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zkBxrdM96XkcLC7Mf6FMfniC4+3m8Q6iJkV6nmXxytY=;
        b=AcB/C6G+8WoZbabAav7PghmOdMWuXEm3YhI/R2yOzSxNsxgoQcrJamUAP1APF7c53T
         PrJeI8hH8sLpBDE9UpGJzqQVhCPYW0l85eCxUIJvXsUGi5ckq9IX6XHU9eWympPTI24h
         J3fXBWvsiuX25aG8cPqIe1PdEkj4NTeAAdvLAMLWyzEb/w3TnxrR/soCiThlzaU2gKAh
         afTajxDBJJZxv7THNwHiWK3EcgFLkofQ3RFegL8d7jADSos3mrhhyquiidrv0P6RFf2+
         qXDkhcnna7Ntj5DPwyHl3XiYhzl6vgsl6vP+MhwlIdDyPiQDVxt7EpdqU9wcBOlJez4r
         8pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zkBxrdM96XkcLC7Mf6FMfniC4+3m8Q6iJkV6nmXxytY=;
        b=ez5gw0HPOYg279uSuE4tCvbUyPDP29RR0osP5nE0DTyjkX8uotcwUGJtE62a2ASAyS
         Kcq5Ux6rKoWenvb+VScrUbrEPkUx1F/ljA86+IFFQ53ZR6ATT5/U8MvOepmO6NcQXOCr
         pMK+ORl4uiYP55ccH8FGz2xL0thzeeq1nYxk4PWNTFi3B+/4APxit+iGGe42AvKn9Mvo
         mSBFB1jFd38qGOBfG6+sR7pMPo0kkaPLEgNNfZT8ykhiB20HP5OoqLoj5ADGU77OM1ym
         zTbBr6i8/4ZC2W5eTbh5ZgLSvkOqo2e0+fNeBoIJbS6U+3yNdzGxhLKkZKqELb82IY0R
         yQfw==
X-Gm-Message-State: AOAM5308F/3rZRZKxF+qH8A7h1k9Dgnza8b96w3D5w2a6zkD+XlnlAkh
        fxA40ngBXVMEhvU7+SIH9lc=
X-Google-Smtp-Source: ABdhPJw9goZ6PLKyK2T4kPEopP5L0GJG7/bVeN40thbAicNWSbhvAI6IqwgD1WlNHVClA8DYrwVnsQ==
X-Received: by 2002:a63:1360:: with SMTP id 32mr5919655pgt.233.1623345321652;
        Thu, 10 Jun 2021 10:15:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21sm454939pgj.74.2021.06.10.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:15:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Jun 2021 10:14:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Erik Rosen <erik.rosen@metormote.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hwmon: (pmbus) Add support for reading direct mode coefficients
Message-ID: <20210610171443.GB3861769@roeck-us.net>
References: <68276e1d-f262-d379-4600-88abdbecddd8@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68276e1d-f262-d379-4600-88abdbecddd8@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

On Thu, Jun 10, 2021 at 05:55:40PM +0100, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity on linux-next has detected a potential
> issue in drivers/hwmon/pmbus/pmbus_core.c with the following commit:
> 
No need to send a patch - I fixed it up by pre-initializing ret.

Thanks,
Guenter

> commit 999d577d7c007d38ab83eee4532d107c2233f78f
> Author: Erik Rosen <erik.rosen@metormote.com>
> Date:   Wed Jun 9 11:32:06 2021 +0200
> 
>     hwmon: (pmbus) Add support for reading direct mode coefficients
> 
> The analysis is as follows:
> 
> 2219 static int pmbus_init_coefficients(struct i2c_client *client,
> 2220                                   struct pmbus_driver_info *info)
> 2221 {
> 
>     1. var_decl: Declaring variable ret without initializer.
> 
> 2222        int i, n, ret;
> 2223        const struct pmbus_class_attr_map *map;
> 2224        const struct pmbus_sensor_attr *attr;
> 2225
> 
>     2. Condition i < 6UL /* sizeof (class_attr_map) / sizeof
> (class_attr_map[0]) + (int)sizeof (struct
> pmbus_init_coefficients::[unnamed type]) */, taking true branch.
> 
>     5. Condition i < 6UL /* sizeof (class_attr_map) / sizeof
> (class_attr_map[0]) + (int)sizeof (struct
> pmbus_init_coefficients::[unnamed type]) */, taking true branch.
> 
>     8. Condition i < 6UL /* sizeof (class_attr_map) / sizeof
> (class_attr_map[0]) + (int)sizeof (struct
> pmbus_init_coefficients::[unnamed type]) */, taking true branch.
> 
> 2226        for (i = 0; i < ARRAY_SIZE(class_attr_map); i++) {
> 2227                map = &class_attr_map[i];
> 
>     3. Condition info->format[map->class] != direct, taking true branch.
>     6. Condition info->format[map->class] != direct, taking true branch.
>     9. Condition info->format[map->class] != direct, taking false branch.
> 
> 2228                if (info->format[map->class] != direct)
> 
>     4. Continuing loop.
>     7. Continuing loop.
> 
> 2229                        continue;
> 
>     10. Condition n < map->nattr, taking true branch.
>     13. Condition n < map->nattr, taking true branch.
>     16. Condition n < map->nattr, taking false branch.
> 
> 2230                for (n = 0; n < map->nattr; n++) {
> 2231                        attr = &map->attr[n];
> 
>     11. Condition map->class != attr->class, taking true branch.
>     14. Condition map->class != attr->class, taking true branch.
> 2232                        if (map->class != attr->class)
>     12. Continuing loop.
>     15. Continuing loop.
> 
> 2233                                continue;
> 2234                        ret = pmbus_read_coefficients(client, info,
> attr);
> 2235                        if (ret >= 0)
> 2236                                break;
> 2237                }
> 
> Uninitialized scalar variable (UNINIT)
>     17. uninit_use: Using uninitialized value ret.
> 
> 2238                if (ret < 0) {
> 2239                        dev_err(&client->dev,
> 2240                                "No coefficients found for sensor
> class %d\n",
> 2241                                map->class);
> 2242                        return -EINVAL;
> 2243                }
> 2244        }
> 2245
> 2246        return 0;
> 2247 }
> 
> With the continue statements on line 2233 (or if map->nattr is zero) it
> may be possible that ret is never assigned a value and so the check on
> line 2238 could be checking an uninitialized variable ret. I'm not sure
> if this is a false positive, but it may be worth initializing ret to
> some sane value to catch these corner cases.
> 
> Colin
> 
