Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAF3A3183
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhFJQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:57:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhFJQ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:57:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lrNy1-0004L4-FD; Thu, 10 Jun 2021 16:55:41 +0000
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Erik Rosen <erik.rosen@metormote.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: hwmon: (pmbus) Add support for reading direct mode coefficients
Message-ID: <68276e1d-f262-d379-4600-88abdbecddd8@canonical.com>
Date:   Thu, 10 Jun 2021 17:55:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with Coverity on linux-next has detected a potential
issue in drivers/hwmon/pmbus/pmbus_core.c with the following commit:

commit 999d577d7c007d38ab83eee4532d107c2233f78f
Author: Erik Rosen <erik.rosen@metormote.com>
Date:   Wed Jun 9 11:32:06 2021 +0200

    hwmon: (pmbus) Add support for reading direct mode coefficients

The analysis is as follows:

2219 static int pmbus_init_coefficients(struct i2c_client *client,
2220                                   struct pmbus_driver_info *info)
2221 {

    1. var_decl: Declaring variable ret without initializer.

2222        int i, n, ret;
2223        const struct pmbus_class_attr_map *map;
2224        const struct pmbus_sensor_attr *attr;
2225

    2. Condition i < 6UL /* sizeof (class_attr_map) / sizeof
(class_attr_map[0]) + (int)sizeof (struct
pmbus_init_coefficients::[unnamed type]) */, taking true branch.

    5. Condition i < 6UL /* sizeof (class_attr_map) / sizeof
(class_attr_map[0]) + (int)sizeof (struct
pmbus_init_coefficients::[unnamed type]) */, taking true branch.

    8. Condition i < 6UL /* sizeof (class_attr_map) / sizeof
(class_attr_map[0]) + (int)sizeof (struct
pmbus_init_coefficients::[unnamed type]) */, taking true branch.

2226        for (i = 0; i < ARRAY_SIZE(class_attr_map); i++) {
2227                map = &class_attr_map[i];

    3. Condition info->format[map->class] != direct, taking true branch.
    6. Condition info->format[map->class] != direct, taking true branch.
    9. Condition info->format[map->class] != direct, taking false branch.

2228                if (info->format[map->class] != direct)

    4. Continuing loop.
    7. Continuing loop.

2229                        continue;

    10. Condition n < map->nattr, taking true branch.
    13. Condition n < map->nattr, taking true branch.
    16. Condition n < map->nattr, taking false branch.

2230                for (n = 0; n < map->nattr; n++) {
2231                        attr = &map->attr[n];

    11. Condition map->class != attr->class, taking true branch.
    14. Condition map->class != attr->class, taking true branch.
2232                        if (map->class != attr->class)
    12. Continuing loop.
    15. Continuing loop.

2233                                continue;
2234                        ret = pmbus_read_coefficients(client, info,
attr);
2235                        if (ret >= 0)
2236                                break;
2237                }

Uninitialized scalar variable (UNINIT)
    17. uninit_use: Using uninitialized value ret.

2238                if (ret < 0) {
2239                        dev_err(&client->dev,
2240                                "No coefficients found for sensor
class %d\n",
2241                                map->class);
2242                        return -EINVAL;
2243                }
2244        }
2245
2246        return 0;
2247 }

With the continue statements on line 2233 (or if map->nattr is zero) it
may be possible that ret is never assigned a value and so the check on
line 2238 could be checking an uninitialized variable ret. I'm not sure
if this is a false positive, but it may be worth initializing ret to
some sane value to catch these corner cases.

Colin

