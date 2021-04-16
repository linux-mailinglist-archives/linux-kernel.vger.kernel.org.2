Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923F362172
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbhDPNvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:51:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:21909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235292AbhDPNvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:51:38 -0400
IronPort-SDR: Z6tewC/AYr6o3jfiNN2/WTZ1dQ5h9KDcbKGl4SJDbWyJEozzxs8VQo9f5SMEZnn5sDz0XydMKu
 dL8fm0sdJcUg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="191852031"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="191852031"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 06:51:13 -0700
IronPort-SDR: 4qeBNESo2iDWea2iE9P/llbjad51PV9mgy3adsxn2f/kNW8HnS8CoM7kSmkZ1jY/t/faJ9BPeM
 qfeL4YOdoFEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="601469781"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2021 06:51:10 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXOsI-0000GL-9n; Fri, 16 Apr 2021 13:51:10 +0000
Date:   Fri, 16 Apr 2021 21:50:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] hwmon: fsp3y_info[] can be static
Message-ID: <20210416135022.GA45876@35342e253913>
References: <202104162123.Fg4Rp1u1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104162123.Fg4Rp1u1-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: fdf70b5de6f3 ("hwmon: Add driver for fsp-3y PSUs and PDUs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 fsp-3y.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index 3ff4bace9a85f..284b73aaed467 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -147,7 +147,7 @@ static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase,
 	return i2c_smbus_read_word_data(client, reg);
 }
 
-struct pmbus_driver_info fsp3y_info[] = {
+static struct pmbus_driver_info fsp3y_info[] = {
 	[ym2151e] = {
 		.pages = 2,
 		.func[YM2151_PAGE_12V_LOG] =
