Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00FD33C093
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhCOPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhCOPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:53:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F0C06174A;
        Mon, 15 Mar 2021 08:53:28 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u62so19140142oib.6;
        Mon, 15 Mar 2021 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7h0hlnirPiOQ4rFB5uSIUzw4P/LAF5IW5T9CCtpEAn0=;
        b=amGNuSx7j3onIDup2RhBxISMUJc2PhnkhK9F0sUfZVFt92reeuDhFSBLWe0C+uYy1k
         b0terI4cAmIEwbra46f/RPZcsAYVQTsnV8EKVti+zUwgiKOV17PehzdyhptvjTWSFGXn
         +f9mgIYsrLkYYizim0Ib6L+z4VDeVT5xqucN0ZQHgiPZSdV6+BNxJV55T+y3qgmK/FGt
         +X7TFICP9nJ83pCZacxkOIarXFqgF/f0A3KI8sdgMKVZTO5X72EF3Asil5MEQpeKq2Xm
         LPeiwdlHb96noXQEf1HthPaPGYMQ8hKJuaXGXe4XOl0mixvFyopY0FKOCRsOOg+dz2EW
         0d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7h0hlnirPiOQ4rFB5uSIUzw4P/LAF5IW5T9CCtpEAn0=;
        b=dh9U6NjLhY9C8mgq1EQclZcKamKjb3BmduUkUvvMhrhDOH0+f+U0eOhnxOsdOnojgW
         pTxJsU1MLeZh3R/ywjMxyVz7hR3KEdLnzPlcPWqyCYWI3yzjsp+9sYvVU29wRdOTEaEk
         V3UV0xcweYlDGGgcHKPniMtht38SAs+/F0W3/S6tJeWiCBh9MR19uPR1DO0jlaChgnBw
         jNOJN1Fo+HUjapW/7r5OziKJjrwJKHM6IjSs+rMfY79ccQ7JDA5kY6WyozdVE47TT36J
         0Xb1/yWjY8Griwn2xr7cZs8TUABLAVZPScFktAA88IZcUukFXNtPHyKUIcbwyTBnS469
         YShg==
X-Gm-Message-State: AOAM5316cXJwKQXyXy6j26Ve3Y5STtC2M51i7qp8eCJwb/mz1pg93F8X
        21sjbdENp4go8zcwW+SJMuhyMJsQ7AE=
X-Google-Smtp-Source: ABdhPJwvPKaGt17IlTUDPFIcLortI7AVYtCNx1Lbmn+CKPJbm29IEmYFKcB/SsKXC/Uu9fl+qYPP8A==
X-Received: by 2002:aca:59d7:: with SMTP id n206mr18984680oib.7.1615823607737;
        Mon, 15 Mar 2021 08:53:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 33sm7174066otp.66.2021.03.15.08.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 08:53:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] hwmon: corsair-psu: add support for critical values
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org
References: <YE93HebFD0acwZIX@monster.powergraphx.local>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <20214c50-5c58-0d3e-5de5-115ed022750e@roeck-us.net>
Date:   Mon, 15 Mar 2021 08:53:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YE93HebFD0acwZIX@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 8:02 AM, Wilken Gottwalt wrote:
> Adds support for reading the critical values of the temperature sensors
> and the rail sensors (voltage and current) once and caches them. Updates
> the naming of the constants following a more clear scheme. Also updates
> the documentation and fixes a typo.
> 
> The new sensors output of a Corsair HX850i will look like this:
> corsairpsu-hid-3-1
> Adapter: HID adapter
> v_in:        230.00 V
> v_out +12v:   12.14 V  (crit min =  +8.41 V, crit max = +15.59 V)
> v_out +5v:     5.03 V  (crit min =  +3.50 V, crit max =  +6.50 V)
> v_out +3.3v:   3.30 V  (crit min =  +2.31 V, crit max =  +4.30 V)
> psu fan:        0 RPM
> vrm temp:     +46.2°C  (crit = +70.0°C)
> case temp:    +39.8°C  (crit = +70.0°C)
> power total: 152.00 W
> power +12v:  108.00 W
> power +5v:    41.00 W
> power +3.3v:   5.00 W
> curr in:          N/A

What does that mean ? If it isn't supported by the power supply,
should we drop that entirely ? Maybe drop it via the is_visible
function if it is available for some variants, but always displaying
N/A doesn't add value.

This is a bit odd, though, since I would assume it translates
to the PSU_CMD_IN_AMPS command. Any chance to track down what is
happening here ?

> curr +12v:     9.00 A  (crit max = +85.00 A)
> curr +5v:      8.31 A  (crit max = +40.00 A)
> curr +3.3v:    1.62 A  (crit max = +40.00 A)
> > This patch changes:
> - hwmon corsair-psu documentation
> - hwmon corsair-psu driver
> 

That is obvious; no reason to state in the commit log.

> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v2:
>   - simplified reading/caching of critical values and hwmon_ops_read function
>   - removed unnecessary debug output and comments
> ---
>  Documentation/hwmon/corsair-psu.rst |  13 +-
>  drivers/hwmon/corsair-psu.c         | 223 +++++++++++++++++++++-------
>  2 files changed, 185 insertions(+), 51 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index 396b95c9a76a..b77e53810a13 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -45,19 +45,30 @@ Sysfs entries
>  -------------
>  
>  =======================	========================================================
> +curr2_crit		Current max critical value on the 12v psu rail
> +curr3_crit		Current max critical value on the 5v psu rail
> +curr4_crit		Current max critical value on the 3.3v psu rail
>  curr1_input		Total current usage
>  curr2_input		Current on the 12v psu rail
>  curr3_input		Current on the 5v psu rail
>  curr4_input		Current on the 3.3v psu rail

I think it would be better to align those by index.

curr1_input
curr2_input
curr2_crit
...

Personally I always list _input first, but that is a matter of
personal preference.

>  fan1_input		RPM of psu fan
> +in1_crit		Voltage max critical value on the 12v psu rail
> +in2_crit		Voltage max critical value on the 5v psu rail
> +in3_crit		Voltage max critical value on the 3.3v psu rail
>  in0_input		Voltage of the psu ac input
>  in1_input		Voltage of the 12v psu rail
>  in2_input		Voltage of the 5v psu rail
> -in3_input		Voltage of the 3.3 psu rail
> +in3_input		Voltage of the 3.3v psu rail
> +in1_lcrit		Voltage min critical value on the 12v psu rail
> +in2_lcrit		Voltage min critical value on the 5v psu rail
> +in3_lcrit		Voltage min critical value on the 3.3v psu rail
>  power1_input		Total power usage
>  power2_input		Power usage of the 12v psu rail
>  power3_input		Power usage of the 5v psu rail
>  power4_input		Power usage of the 3.3v psu rail
> +temp1_crit		Temperature max cirtical value of the psu vrm component
> +temp2_crit		Temperature max critical value of psu case
>  temp1_input		Temperature of the psu vrm component
>  temp2_input		Temperature of the psu case
>  =======================	========================================================
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index b0953eeeb2d3..a176ac6a2540 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -53,11 +53,17 @@
>  #define CMD_TIMEOUT_MS		250
>  #define SECONDS_PER_HOUR	(60 * 60)
>  #define SECONDS_PER_DAY		(SECONDS_PER_HOUR * 24)
> +#define RAIL_COUNT		3 /* 3v3 + 5v + 12v */
> +#define TEMP_COUNT		2
>  
>  #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
> -#define PSU_CMD_IN_VOLTS	0x88 /* the rest of the commands expect length 3 */
> +#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
> +#define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
> +#define PSU_CMD_RAIL_AMPS_HCRIT	0x46
> +#define PSU_CMD_TEMP_HCRIT	0x4F
> +#define PSU_CMD_IN_VOLTS	0x88
>  #define PSU_CMD_IN_AMPS		0x89
> -#define PSU_CMD_RAIL_OUT_VOLTS	0x8B
> +#define PSU_CMD_RAIL_VOLTS	0x8B
>  #define PSU_CMD_RAIL_AMPS	0x8C
>  #define PSU_CMD_TEMP0		0x8D
>  #define PSU_CMD_TEMP1		0x8E
> @@ -116,6 +122,14 @@ struct corsairpsu_data {
>  	u8 *cmd_buffer;
>  	char vendor[REPLY_SIZE];
>  	char product[REPLY_SIZE];
> +	long temp_crit[TEMP_COUNT];
> +	long in_crit[RAIL_COUNT];
> +	long in_lcrit[RAIL_COUNT];
> +	long curr_crit[RAIL_COUNT];
> +	u8 temp_crit_support;
> +	u8 in_crit_support;
> +	u8 in_lcrit_support;
> +	u8 curr_crit_support;
>  };
>  
>  /* some values are SMBus LINEAR11 data which need a conversion */
> @@ -193,7 +207,10 @@ static int corsairpsu_request(struct corsairpsu_data *priv, u8 cmd, u8 rail, voi
>  
>  	mutex_lock(&priv->lock);
>  	switch (cmd) {
> -	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_VOLTS_HCRIT:
> +	case PSU_CMD_RAIL_VOLTS_LCRIT:
> +	case PSU_CMD_RAIL_AMPS_HCRIT:
> +	case PSU_CMD_RAIL_VOLTS:
>  	case PSU_CMD_RAIL_AMPS:
>  	case PSU_CMD_RAIL_WATTS:
>  		ret = corsairpsu_usb_cmd(priv, 2, PSU_CMD_SELECT_RAIL, rail, NULL);
> @@ -229,9 +246,13 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	 */
>  	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
>  	switch (cmd) {
> +	case PSU_CMD_RAIL_VOLTS_HCRIT:
> +	case PSU_CMD_RAIL_VOLTS_LCRIT:
> +	case PSU_CMD_RAIL_AMPS_HCRIT:
> +	case PSU_CMD_TEMP_HCRIT:
>  	case PSU_CMD_IN_VOLTS:
>  	case PSU_CMD_IN_AMPS:
> -	case PSU_CMD_RAIL_OUT_VOLTS:
> +	case PSU_CMD_RAIL_VOLTS:
>  	case PSU_CMD_RAIL_AMPS:
>  	case PSU_CMD_TEMP0:
>  	case PSU_CMD_TEMP1:
> @@ -256,75 +277,175 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	return ret;
>  }
>  
> +static void corsairpsu_get_criticals(struct corsairpsu_data *priv)
> +{
> +	long tmp;
> +	int ret;
> +	u8 rail;

Side note: Using anything but sizeof(int) for index variables often results in more
complex code because the compiler needs to mask index operations. This doesn't
typically apply to x86 because that architecure has byte operations, but to pretty
much every other architecture.

> +
> +	priv->temp_crit_support = 0;
> +	priv->in_lcrit_support = 0;
> +	priv->in_crit_support = 0;
> +	priv->curr_crit_support = 0;
> +
> +	for (rail = 0; rail < TEMP_COUNT; ++rail) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp);
> +		if (ret == 0) {

Nit: the ret variable isn't really needed here.
		if (!corsairpsu_get_value(priv, PSU_CMD_TEMP_HCRIT, rail, &tmp)) {
works just as well. Personal preference, though.

> +			priv->temp_crit_support |= BIT(rail);
> +			priv->temp_crit[rail] = tmp;
> +		}
> +	}
> +
> +	for (rail = 0; rail < RAIL_COUNT; ++rail) {
> +		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_HCRIT, rail, &tmp);
> +		if (ret == 0) {
> +			priv->in_crit_support |= BIT(rail);
> +			priv->in_crit[rail] = tmp;
> +		}
> +
> +		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS_LCRIT, rail, &tmp);
> +		if (ret == 0) {
> +			priv->in_lcrit_support |= BIT(rail);
> +			priv->in_lcrit[rail] = tmp;
> +		}
> +
> +		ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS_HCRIT, rail, &tmp);
> +		if (ret == 0) {
> +			priv->curr_crit_support |= BIT(rail);
> +			priv->curr_crit[rail] = tmp;
> +		}
> +	}
> +}
> +
>  static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sensor_types type,
>  					       u32 attr, int channel)
>  {
> -	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label))
> +	if (type == hwmon_temp && (attr == hwmon_temp_input || attr == hwmon_temp_label ||
> +				   attr == hwmon_temp_crit))
>  		return 0444;
>  	else if (type == hwmon_fan && (attr == hwmon_fan_input || attr == hwmon_fan_label))
>  		return 0444;
>  	else if (type == hwmon_power && (attr == hwmon_power_input || attr == hwmon_power_label))
>  		return 0444;
> -	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label))
> +	else if (type == hwmon_in && (attr == hwmon_in_input || attr == hwmon_in_label ||
> +				      attr == hwmon_in_lcrit || attr == hwmon_in_crit))
>  		return 0444;
> -	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label))
> +	else if (type == hwmon_curr && (attr == hwmon_curr_input || attr == hwmon_curr_label ||
> +					attr == hwmon_curr_crit))
>  		return 0444;
>  
>  	return 0;
>  }
>  
> -static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> -				     int channel, long *val)
> +static int corsairpsu_hwmon_temp(struct corsairpsu_data *priv, u32 attr, int channel, long *val)

Please make those functions _<type>_read, not just _<type>. It makes the code easier
to understand, and we won't have to change it if write functions are ever added.

>  {
> -	struct corsairpsu_data *priv = dev_get_drvdata(dev);
> -	int ret;
> +	int err = -EOPNOTSUPP;
> +
> +	if (channel < 2) {
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0,
> +						    channel, val);
> +		case hwmon_temp_crit:
> +			if (priv->temp_crit_support & BIT(channel)) {
> +				*val = priv->temp_crit[channel];
> +				err = 0;
> +			}
> +		}

Dropping default cases from switch statements is never a good idea. It hides missing
break statements, like here, and it may result in compiler or static analyzer warnings
that not all situations are covered. Please don't do that (neither skipping break;
statements not dropping default:). Yes, it technically can' happen, but that kind of
code invites bugs if/when it is modified later. Pus, it shows that you thought about
that case, even if it is only
		default:
			break;

> +	}
>  
> -	if (type == hwmon_temp && attr == hwmon_temp_input && channel < 2) {
> -		ret = corsairpsu_get_value(priv, channel ? PSU_CMD_TEMP1 : PSU_CMD_TEMP0, channel,
> -					   val);
> -	} else if (type == hwmon_fan && attr == hwmon_fan_input) {
> -		ret = corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> -	} else if (type == hwmon_power && attr == hwmon_power_input) {
> +	return err;
> +}
> +
> +static int corsairpsu_hwmon_power(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
> +{
> +	if (attr == hwmon_power_input) {
>  		switch (channel) {
>  		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_TOTAL_WATTS, 0, val);
>  		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);
> -			break;
> -		default:
> -			return -EOPNOTSUPP;
> +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_WATTS, channel - 1, val);

Same as above and below.

>  		}
> -	} else if (type == hwmon_in && attr == hwmon_in_input) {
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int corsairpsu_hwmon_in(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
> +{
> +	int err = -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_in_input:
>  		switch (channel) {
>  		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_IN_VOLTS, 0, val);
>  		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_OUT_VOLTS, channel - 1, val);
> -			break;
> -		default:
> -			return -EOPNOTSUPP;
> +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_VOLTS, channel - 1, val);
> +		}
> +		break;
> +	case hwmon_in_crit:
> +		if (priv->in_crit_support & BIT(channel - 1)) {
> +			*val = priv->in_crit[channel - 1];
> +			err = 0;
>  		}
> -	} else if (type == hwmon_curr && attr == hwmon_curr_input) {
> +		break;
> +	case hwmon_in_lcrit:
> +		if (priv->in_lcrit_support & BIT(channel - 1)) {
> +			*val = priv->in_lcrit[channel - 1];
> +			err = 0;
> +		}
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static int corsairpsu_hwmon_curr(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
> +{
> +	int err = -EOPNOTSUPP;
> +
> +	switch (attr) {
> +	case hwmon_curr_input:
>  		switch (channel) {
>  		case 0:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
> -			break;
> +			return corsairpsu_get_value(priv, PSU_CMD_IN_AMPS, 0, val);
>  		case 1 ... 3:
> -			ret = corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
> -			break;
> -		default:
> -			return -EOPNOTSUPP;
> +			return corsairpsu_get_value(priv, PSU_CMD_RAIL_AMPS, channel - 1, val);
>  		}
> -	} else {
> -		return -EOPNOTSUPP;
> +		break;
> +	case hwmon_curr_crit:
> +		if (priv->curr_crit_support & BIT(channel - 1)) {
> +			*val = priv->curr_crit[channel - 1];
> +			err = 0;
> +		}
> +		break;
>  	}
>  
> -	if (ret < 0)
> -		return ret;
> +	return err;
> +}
>  
> -	return 0;

Nice, you found that :-)

> +static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				     int channel, long *val)
> +{
> +	struct corsairpsu_data *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return corsairpsu_hwmon_temp(priv, attr, channel, val);
> +	case hwmon_fan:
> +		if (attr == hwmon_fan_input)
> +			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
> +		return -EOPNOTSUPP;
> +	case hwmon_power:
> +		return corsairpsu_hwmon_power(priv, attr, channel, val);
> +	case hwmon_in:
> +		return corsairpsu_hwmon_in(priv, attr, channel, val);
> +	case hwmon_curr:
> +		return corsairpsu_hwmon_curr(priv, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int corsairpsu_hwmon_ops_read_string(struct device *dev, enum hwmon_sensor_types type,
> @@ -360,8 +481,8 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
>  	HWMON_CHANNEL_INFO(chip,
>  			   HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(temp,
> -			   HWMON_T_INPUT | HWMON_T_LABEL,
> -			   HWMON_T_INPUT | HWMON_T_LABEL),
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT,
> +			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
>  	HWMON_CHANNEL_INFO(fan,
>  			   HWMON_F_INPUT | HWMON_F_LABEL),
>  	HWMON_CHANNEL_INFO(power,
> @@ -371,14 +492,14 @@ static const struct hwmon_channel_info *corsairpsu_info[] = {
>  			   HWMON_P_INPUT | HWMON_P_LABEL),
>  	HWMON_CHANNEL_INFO(in,
>  			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL,
> -			   HWMON_I_INPUT | HWMON_I_LABEL),
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT,
> +			   HWMON_I_INPUT | HWMON_I_LABEL | HWMON_I_LCRIT | HWMON_I_CRIT),
>  	HWMON_CHANNEL_INFO(curr,
>  			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL,
> -			   HWMON_C_INPUT | HWMON_C_LABEL),
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT,
> +			   HWMON_C_INPUT | HWMON_C_LABEL | HWMON_C_CRIT),
>  	NULL
>  };
>  
> @@ -513,6 +634,8 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct hid_device_id
>  		goto fail_and_stop;
>  	}
>  
> +	corsairpsu_get_criticals(priv);
> +
>  	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "corsairpsu", priv,
>  							  &corsairpsu_chip_info, 0);
>  
> 

