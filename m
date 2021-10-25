Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB243A3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhJYUGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:06:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:60200 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240517AbhJYUDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:03:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="209833218"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="209833218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:49:27 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="446776866"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:49:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mf5xu-000xNZ-JJ;
        Mon, 25 Oct 2021 22:49:02 +0300
Date:   Mon, 25 Oct 2021 22:49:02 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <YXcKLvRu3gRm3zUF@smile.fi.intel.com>
References: <20211022200032.23267-1-pauk.denis@gmail.com>
 <20211022200032.23267-2-pauk.denis@gmail.com>
 <YXcDcXrUo4a/KAsT@smile.fi.intel.com>
 <YXcHYvleoOr6sqMK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXcHYvleoOr6sqMK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:37:06PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 25, 2021 at 10:20:17PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 22, 2021 at 11:00:29PM +0300, Denis Pauk wrote:

...

> > Below is a follow up, I have not compiled it.
> > Feel free to take fully or partially.

Okay, here a few additional fixes (make them symmetrical and hope that
it will compile now):

diff --git a/drivers/hwmon/asus_wmi_ec_sensors.c b/drivers/hwmon/asus_wmi_ec_sensors.c
index 870de5a7f20d..d39271b5e50c 100644
--- a/drivers/hwmon/asus_wmi_ec_sensors.c
+++ b/drivers/hwmon/asus_wmi_ec_sensors.c
@@ -261,10 +261,7 @@ static int asus_wmi_ec_fill_board_sensors(struct asus_wmi_ec_info *ec,
 static int asus_wmi_ec_decode_reply_buffer(const u8 *in, u32 length, u8 *out)
 {
 	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
-	u32 len;
-
-	/* Minimum of size of response and size of ACPI result (in bytes) */
-	len = min_t(u32, in[0], length - 2);
+	u32 len = min_t(u32, get_unaligned_le16(in), length - 2);
 
 	utf16s_to_utf8s((wchar_t *)(in + 2), len / 2, UTF16_LITTLE_ENDIAN, buffer, sizeof(buffer));
 
@@ -274,13 +271,13 @@ static int asus_wmi_ec_decode_reply_buffer(const u8 *in, u32 length, u8 *out)
 static void asus_wmi_ec_encode_registers(const u8 *in, u32 length, char *out)
 {
 	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
-	u16 len = nr_registers * 2;
-
-	put_unaligned_le16(len * 2, out);
+	u32 len = length;
 
 	bin2hex(buffer, in, len);
 
 	utf8s_to_utf16s(buffer, len * 2, UTF16_LITTLE_ENDIAN, (wchar_t *)(out + 2), len);
+
+	put_unaligned_le16(len * 2, out);
 }
 
 static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
@@ -298,7 +295,7 @@ static void asus_wmi_ec_make_block_read_query(struct asus_wmi_ec_info *ec)
 		}
 	}
 
-	asus_wmi_ec_encode_registers(registers, ec->nr_registers, ec->read_arg);
+	asus_wmi_ec_encode_registers(registers, offset, ec->read_arg);
 }
 
 static int asus_wmi_ec_block_read(u32 method_id, char *query, u8 *out)

-- 
With Best Regards,
Andy Shevchenko


