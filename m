Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA41408B48
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhIMMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235668AbhIMMqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C0AD60FC0;
        Mon, 13 Sep 2021 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631537091;
        bh=92CGi6pxF3eMSXpW+yo6AMpUe2BI77PKsCi+SxDsoGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reVT8C3DI0dRgnkwAkbNF5xZGV0Or57b9f6d4enEbe8PEdZKpk19Rjx8ExHJYy8rn
         V1Sh6Da49+8oQpVcj5xqH/zgunBhMFWMY/Dh1apzqqJK9do5vnjRfYYeUpoL/2Vau0
         lL3DQ7G2l7+rTdT2B0oHqpUfVEgz3bp58GN4l108HbNvZd6y10cd/Sz6wzUDrZ+Dk3
         GmtfUaYqRc3EsYZDUEO2ZUfaAHITpLfjFceF3K4jiU6azNmT8mI+mMza1SajUTbEln
         1qGBM/9GWTqxemRWDh0dgUx7dVz1tGnoO4jt/5d/C4cZkC96/TcFXD3bn/FW1IkaD6
         GMPNpv4WpjpLQ==
Received: by pali.im (Postfix)
        id 258B9891; Mon, 13 Sep 2021 14:44:49 +0200 (CEST)
Date:   Mon, 13 Sep 2021 14:44:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Troy Rollo <linux2021@troy.rollo.name>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process tablet mode events on Dell Inspiron 2n1
Message-ID: <20210913124448.jnkpbya2eyq2mcqb@pali>
References: <20210909033502.1994749-1-linux2021@troy.rollo.name>
 <776ba42d-1d87-81e9-ed36-3ef860869d93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776ba42d-1d87-81e9-ed36-3ef860869d93@redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2021 14:40:28 Hans de Goede wrote:
> Hi,
> 
> Overall this patch looks good, I have 2 remarks:
> 
> 1. Your commit message needs some work, the first line (Subject) should
> briefly describe the change with a subsystem prefix, so something like this:
> 
> platform/x86: dell-wmi: Add SW_TABLET_MODE support for Dell Inspiron 2in1
> 
> And then an empty line followed by a "body" with a bit more detailed description.
> 
> And last but not least you need to add a Signed-off-by line like this:
> 
> Singed-off-by: Troy Rollo <linux2021@troy.rollo.name>
> 
> Which indicates that you authored the patch and are submitting it under
> the standard kernel license, see:
> https://elinux.org/Developer_Certificate_Of_Origin
> 
> 2. Also have 1 remark about the code, see below.
> 
> 
> On 9/9/21 5:35 AM, Troy Rollo wrote:
> > ---
> >  drivers/platform/x86/dell/dell-wmi-base.c | 36 ++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> > index 089c125e18f7..474ca05055ab 100644
> > --- a/drivers/platform/x86/dell/dell-wmi-base.c
> > +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> > @@ -309,6 +309,9 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
> >   * Keymap for WMI events of type 0x0011
> >   */
> >  static const struct key_entry dell_wmi_keymap_type_0011[] = {
> > +	/* Reflex keyboard switch on 2n1 devices */
> > +	{ KE_VSW,    0xe070, { .sw  = { SW_TABLET_MODE } } },
> > +
> 
> By adding this here, any device loading the dell-wmi driver will now advertise
> that it supports SW_TABLET_MODE reporting, even when it does not. This will
> cause e.g. GNOME40 to disable accelerometer based rotation since when
> SW_TABLET_MODE=0 is being reported then GNOME40 assumes it is running on a
> 2in1 in laptop mode and thus disable auto-rotation (and also the on-screen-kbd).
> 
> So advertising a non functional (always reporting 0) SW_TABLET_MODE switch
> is harmful and this change will do this.

Good catch. This code needs some rework as based on above gnome
behavior, this change breaks support for all existing older Dell
laptops.

It it problem only with SW_TABLET_MODE? Or with any KE_VSW?

> Since you already have special handling for the tablet-mode WMI events,
> it would be better to use a separate input-device which just reports
> SW_TABLET_MODE and which gets dynamically created upon receiving the
> first 0x0011 0xe070 event. See the
> drivers/platform/x86/intel/vbtn.c
> drivers/platform/x86/intel/hid.c
> 
> Drivers for an example of 2 drivers already doing this.
> 
> Regards,
> 
> Hans
> 
> 
> 
> >  	/* Battery unplugged */
> >  	{ KE_IGNORE, 0xfff0, { KEY_RESERVED } },
> >  
> > @@ -344,17 +347,19 @@ static const struct key_entry dell_wmi_keymap_type_0012[] = {
> >  	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
> >  };
> >  
> > -static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
> > +static int dell_wmi_process_key(struct wmi_device *wdev, int type, int code, u16 *buffer, int remaining)
> >  {
> >  	struct dell_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
> >  	const struct key_entry *key;
> > +	int used = 0;
> > +	int value = 1;
> >  
> >  	key = sparse_keymap_entry_from_scancode(priv->input_dev,
> >  						(type << 16) | code);
> >  	if (!key) {
> >  		pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n",
> >  			type, code);
> > -		return;
> > +		return 0;
> >  	}
> >  
> >  	pr_debug("Key with type 0x%04x and code 0x%04x pressed\n", type, code);
> > @@ -363,16 +368,22 @@ static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
> >  	if ((key->keycode == KEY_BRIGHTNESSUP ||
> >  	     key->keycode == KEY_BRIGHTNESSDOWN) &&
> >  	    acpi_video_handles_brightness_key_presses())
> > -		return;
> > +		return 0;
> >  
> >  	if (type == 0x0000 && code == 0xe025 && !wmi_requires_smbios_request)
> > -		return;
> > +		return 0;
> >  
> > -	if (key->keycode == KEY_KBDILLUMTOGGLE)
> > +	if (key->keycode == KEY_KBDILLUMTOGGLE) {
> >  		dell_laptop_call_notifier(
> >  			DELL_LAPTOP_KBD_BACKLIGHT_BRIGHTNESS_CHANGED, NULL);
> > +	} else if (type == 0x0011 && code == 0xe070 && remaining > 0) {
> > +		value = !buffer[0];
> > +		used = 1;
> > +	}
> > +
> > +	sparse_keymap_report_entry(priv->input_dev, key, value, true);
> >  
> > -	sparse_keymap_report_entry(priv->input_dev, key, 1, true);
> > +	return used;
> >  }
> >  
> >  static void dell_wmi_notify(struct wmi_device *wdev,
> > @@ -430,21 +441,26 @@ static void dell_wmi_notify(struct wmi_device *wdev,
> >  		case 0x0000: /* One key pressed or event occurred */
> >  			if (len > 2)
> >  				dell_wmi_process_key(wdev, buffer_entry[1],
> > -						     buffer_entry[2]);
> > +						     buffer_entry[2],
> > +						     buffer_entry + 3,
> > +						     len - 3);
> >  			/* Extended data is currently ignored */
> >  			break;
> >  		case 0x0010: /* Sequence of keys pressed */
> >  		case 0x0011: /* Sequence of events occurred */
> >  			for (i = 2; i < len; ++i)
> > -				dell_wmi_process_key(wdev, buffer_entry[1],
> > -						     buffer_entry[i]);
> > +				i += dell_wmi_process_key(wdev, buffer_entry[1],
> > +							  buffer_entry[i],
> > +							  buffer_entry + i,
> > +							  len - i - 1);
> >  			break;
> >  		case 0x0012:
> >  			if ((len > 4) && dell_privacy_process_event(buffer_entry[1], buffer_entry[3],
> >  								    buffer_entry[4]))
> >  				/* dell_privacy_process_event has handled the event */;
> >  			else if (len > 2)
> > -				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2]);
> > +				dell_wmi_process_key(wdev, buffer_entry[1], buffer_entry[2],
> > +						     buffer_entry + 3, len - 3);
> >  			break;
> >  		default: /* Unknown event */
> >  			pr_info("Unknown WMI event type 0x%x\n",
> > 
> 
