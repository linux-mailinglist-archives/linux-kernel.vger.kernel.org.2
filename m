Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8122845F11E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354336AbhKZP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:57:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:44146 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378062AbhKZPzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:55:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="233174261"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="233174261"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:51:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="607902111"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:51:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqdVo-00ApLI-AP;
        Fri, 26 Nov 2021 17:51:44 +0200
Date:   Fri, 26 Nov 2021 17:51:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, 282827961@qq.com
Subject: Re: [PATCH v17] tty: Fix the keyboard led light display problem
Message-ID: <YaECkE+Tc7btwAEO@smile.fi.intel.com>
References: <20211126112727.14939-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126112727.14939-1-changlianzhi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 07:27:27PM +0800, lianzhi chang wrote:
> By judging the value of kb->kbdmode to determine whether it is necessary
> to forcibly set the led state of the keyboard when switching between
> different ttys. Solve the problem of the inconsistency between the
> keyboard led status and the keyboard lock status in some scenarios,
> such as the scenario where the desktop and tty switch mutually.

Since it will be a next version, see one comment below you may address as well.

...

> +	/*
> +	 * When switching VT, according to the value of kb->kbdmode,
> +	 * judge whether it is necessary to force the keyboard light
> +	 * state to be issued.
> +	 */
> +	kb = kbd_table + fg_console;
> +	if (kb->kbdmode == VC_RAW ||
> +	     kb->kbdmode == VC_MEDIUMRAW ||
> +	     kb->kbdmode == VC_OFF) {

checkpatch usually complains on indentation above.

Can you simply do it like

	if (kb->kbdmode == VC_RAW ||
	    kb->kbdmode == VC_MEDIUMRAW ||
	    kb->kbdmode == VC_OFF) {

?

Alternatively it might be converted to a switch-case, but it takes more LOCs.

	switch {
	case VC_RAW:
	case VC_MEDIUMRAW :
	case VC_OFF:
		vt_switch = true;
		set_leds();
		break;
	default:
		break;
	}

> +		vt_switch = true;
> +		set_leds();
> +	}

-- 
With Best Regards,
Andy Shevchenko


