Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B032343A2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbhJYTvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:51:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:22848 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237782AbhJYTp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:45:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="227200586"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="227200586"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="528902325"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:37:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mf5mM-000x8H-Tj;
        Mon, 25 Oct 2021 22:37:06 +0300
Date:   Mon, 25 Oct 2021 22:37:06 +0300
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
Message-ID: <YXcHYvleoOr6sqMK@smile.fi.intel.com>
References: <20211022200032.23267-1-pauk.denis@gmail.com>
 <20211022200032.23267-2-pauk.denis@gmail.com>
 <YXcDcXrUo4a/KAsT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXcDcXrUo4a/KAsT@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:20:17PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 22, 2021 at 11:00:29PM +0300, Denis Pauk wrote:
> > Linux HWMON sensors driver for ASUS motherboards to read
> > sensors from the embedded controller.
> > 
> > Many ASUS motherboards do not publish all the available
> > sensors via the Super I/O chip but the missing ones are
> > available through the embedded controller (EC) registers.
> > 
> > This driver implements reading those sensor data via the
> > WMI method BREC, which is known to be present in all ASUS
> > motherboards based on the AMD 500 series chipsets (and
> > probably is available in other models too). The driver
> > needs to know exact register addresses for the sensors and
> > thus support for each motherboard has to be added explicitly.
> > 
> > The EC registers do not provide critical values for the
> > sensors and as such they are not published to the HWMON.
> > 
> > Supported motherboards:
> > * PRIME X570-PRO
> > * Pro WS X570-ACE
> > * ROG CROSSHAIR VIII HERO
> > * ROG CROSSHAIR VIII DARK HERO
> > * ROG CROSSHAIR VIII FORMULA
> > * ROG STRIX X570-E GAMING
> > * ROG STRIX B550-E GAMING
> 
> Below is a follow up, I have not compiled it.
> Feel free to take fully or partially.

...

> -static int asus_wmi_ec_decode_reply_buffer(const u8 *inp, u8 *out, u32 length)
> +static int asus_wmi_ec_decode_reply_buffer(const u8 *in, u32 length, u8 *out)
>  {
>  	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
> -	const char *pos = buffer;
> -	const u8 *data = inp + 2;
>  	u32 len;
>  
> -	/* Minimum of size of response and size of ACPI result*/
> -	len = min_t(u32, inp[0] / 4, (length - 2) / 4);
> -	len = min_t(u32, len, ASUSWMI_MAX_BUF_LEN);
> +	/* Minimum of size of response and size of ACPI result (in bytes) */
> +	len = min_t(u32, in[0], length - 2);

Of course this should be

        len = min_t(u32, get_unaligned_le16(in), length - 2);

(compare to the opposite below).

> -	utf16s_to_utf8s((wchar_t *)data, len * 2,  UTF16_LITTLE_ENDIAN, buffer, len * 2);
> +	utf16s_to_utf8s((wchar_t *)(in + 2), len / 2, UTF16_LITTLE_ENDIAN, buffer, sizeof(buffer));
>  
> -	return hex2bin(out, pos, len);
> +	return hex2bin(out, buffer, len / 2);
>  }
>  
> -static void asus_wmi_ec_encode_registers(const u16 *registers, u8 len, char *out)
> +static void asus_wmi_ec_encode_registers(const u8 *in, u32 length, char *out)
>  {
>  	char buffer[ASUSWMI_MAX_BUF_LEN * 2];
> -	char *pos = buffer;
> -	unsigned int i;
> -	u8 byte;
> -
> -	*out++ = len * 8;
> -	*out++ = 0;
> -
> -	for (i = 0; i < len; i++) {
> -		byte = registers[i] >> 8;
> -		pos = bin2hex(pos, &byte, 1);
> -		byte = registers[i];
> -		pos = bin2hex(pos, &byte, 1);
> -	}
> +	u16 len = nr_registers * 2;
> +
> +	put_unaligned_le16(len * 2, out);
> +
> +	bin2hex(buffer, in, len);
>  
> -	utf8s_to_utf16s(buffer, len * 4, UTF16_LITTLE_ENDIAN, (wchar_t *)out, len * 4);
> +	utf8s_to_utf16s(buffer, len * 2, UTF16_LITTLE_ENDIAN, (wchar_t *)(out + 2), len);
>  }

-- 
With Best Regards,
Andy Shevchenko


