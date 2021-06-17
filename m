Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD03AB67B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhFQOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhFQOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:52:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11017C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:50:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l9so3629445wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sovW53vZzwNZ+CWBEOJUqVCEkjbPTO8/7ULAUUt2X7M=;
        b=gGQBAiZtfRFGikkRo+S6ImfMRaqqCIp7rwYr5AlKArIhg0ldA0lodbUUotsneNobtM
         7MVWZQHMa/Zkrx/HfmijKv1Kci0PCSBqb17LNBiC/kmZZqXZCIYq4rQbAcbe1WpSz4iR
         n71S+YD4//sRn73uet3fn4Sa6Dy/U2ldqg/Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sovW53vZzwNZ+CWBEOJUqVCEkjbPTO8/7ULAUUt2X7M=;
        b=c8wF5vd3G1VwcomViJ54MusIztcTONhfBhQ3LsP4rnw6Ew1aUa0mSd+wv44wwEyEoO
         EWn7YyzH7oqFqYb2Gc4d5d6AJUGCA9ozpDlQslOn+Czh1J/1mFnpIjL9jqQZvXcvjbev
         CfvcF29YGK08Xvvkmq0a/BMXMagPulcgXrG4v8FuaWWcSPRSXePeldsUGcFn5X7pFArt
         oC2j4OzLDWFPLnDiP3Xa12c77UNkDspTT2m8ihCtMLvmAcEXmTx7BKrjvCstcrGnc21X
         JVNpSq4ZVxfNPBiZ9LcdCQSR1Ie2liVnCMRD5k/7a+vuY86tIKZjDShGwTz38dcfrn+Y
         zahw==
X-Gm-Message-State: AOAM5318Ob+bwU8t5rreWFbprAVhcQE2pOZ9AH0y0jJuJyZB1t6scE3t
        FNe0vuPbVhAW+ebvCOkavq/RKw==
X-Google-Smtp-Source: ABdhPJyOojYUFsSVVpDiDVrWBAhLnCRv1+/iDchMZfOBB32+R11kqqU1dRMxrhJXtbZJQTdXmlZKGw==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr5535169wmi.177.1623941430436;
        Thu, 17 Jun 2021 07:50:30 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:7326])
        by smtp.gmail.com with ESMTPSA id h6sm5916691wrt.20.2021.06.17.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:50:29 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:50:29 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 0/5] printk: Userspace format indexing support
Message-ID: <YMthNX8uHwLo4i/y@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
 <YMsfo3/b1LvOoiM0@alley>
 <CAHp75VchoFoso54i1XHom_Wt49MtMEnjxZ-vq_C+OXCCK2=8sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHp75VchoFoso54i1XHom_Wt49MtMEnjxZ-vq_C+OXCCK2=8sA@mail.gmail.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko writes:
>Assuming that Chris indeed spent time on checking string_esape_mem()
>users along with %*pE (and all its variations with hardcoded length)
>and haven't found any problems,
>Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks! Probably worth documenting my methodology :-)

Forgive the lack of wrapping -- I suspect it will probably make this easier to 
read.

   % git grep '"[^"]*%[*0-9]*pE[^"]*"'
   drivers/gpu/drm/drm_dp_cec.c:   seq_printf(file, "ID: %*pE\n",
   drivers/gpu/drm/drm_dp_dual_mode_helper.c:      drm_dbg_kms(dev, "DP dual mode HDMI ID: %*pE (err %zd)\n",
   drivers/gpu/drm/drm_dp_helper.c:                    "%s: DP %s: OUI %*phD dev-ID %*pE HW-rev %d.%d SW-rev %d.%d quirks 0x%04x\n",
   drivers/net/wireless/intel/ipw2x00/ipw2100.c:   IPW_DEBUG_INFO("%s: Associated with '%*pE' at %s, channel %d (BSSID=%pM)\n",
   drivers/net/wireless/intel/ipw2x00/ipw2100.c:   IPW_DEBUG_HC("SSID: '%*pE'\n", ssid_len, essid);
   drivers/net/wireless/intel/ipw2x00/ipw2100.c:             "disassociated: '%*pE' %pM\n", priv->essid_len, priv->essid,
   drivers/net/wireless/intel/ipw2x00/ipw2100.c:   IPW_DEBUG_WX("Setting ESSID: '%*pE' (%d)\n", length, essid, length);
   drivers/net/wireless/intel/ipw2x00/ipw2100.c:           IPW_DEBUG_WX("Getting essid: '%*pE'\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                                             "associated: '%*pE' %pM\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                                                     "deauthenticated: '%*pE' %pM: (0x%04X) - %s\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                                             "authenticated: '%*pE' %pM\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                                             "disassociated: '%*pE' %pM\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                                     "authenticated: '%*pE' %pM\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                                     "deauthenticated: '%*pE' %pM\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded due to capability mismatch.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                   IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of non-network ESSID.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                   IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of ESSID mismatch: '%*pE'.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE excluded because newer than current network.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE excluded because newer than current network.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of age: %ums.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of channel mismatch: %d != %d.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of privacy mismatch: %s != %s.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of the same BSSID match: %pM.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of invalid frequency/mode combination.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because configured rate mask excludes AP mandatory rate.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_MERGE("Network '%*pE (%pM)' excluded because of no compatible rates.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:   IPW_DEBUG_MERGE("Network '%*pE (%pM)' is a viable match.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                   IPW_DEBUG_MERGE("remove network %*pE\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded due to capability mismatch.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                   IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of non-network ESSID.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                   IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of ESSID mismatch: '%*pE'.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because '%*pE (%pM)' has a stronger signal.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of storming (%ums since last assoc attempt).\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of age: %ums.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of channel mismatch: %d != %d.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of privacy mismatch: %s != %s.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of BSSID mismatch: %pM.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of invalid frequency/mode combination.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of invalid channel in current GEO\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because configured rate mask excludes AP mandatory rate.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_ASSOC("Network '%*pE (%pM)' excluded because of no compatible rates.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:   IPW_DEBUG_ASSOC("Network '%*pE (%pM)' is a viable match.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_INFO("ESSID locked to '%*pE'\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:   IPW_DEBUG_ASSOC("%ssociation attempt: '%*pE', channel %d, 802.11%c [%d], %s[:%s], enc=%s%s%s%c%c\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:   IPW_DEBUG(IPW_DL_STATE, "associating: '%*pE' %pM\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:                   IPW_DEBUG_ASSOC("Expired '%*pE' (%pM) from network list.\n",
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:   IPW_DEBUG_WX("Setting ESSID: '%*pE' (%d)\n", length, extra, length);
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:           IPW_DEBUG_WX("Getting essid: '%*pE'\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c:                 LIBIPW_DEBUG_MGMT("WLAN_EID_SSID: '%*pE' len=%d.\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c:         LIBIPW_DEBUG_SCAN("Filtered out '%*pE (%pM)' network.\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c: LIBIPW_DEBUG_SCAN("'%*pE' (%pM): %c%c%c%c %c%c%c%c-%c%c%c%c %c%c%c%c\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c:         LIBIPW_DEBUG_SCAN("Dropped '%*pE' (%pM) via %s.\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c:                 LIBIPW_DEBUG_SCAN("Expired '%*pE' (%pM) from network list.\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c:         LIBIPW_DEBUG_SCAN("Adding '%*pE' (%pM) via %s.\n",
   drivers/net/wireless/intel/ipw2x00/libipw_rx.c:         LIBIPW_DEBUG_SCAN("Updating '%*pE' (%pM) via %s.\n",
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:                 LIBIPW_DEBUG_SCAN("Not showing network '%*pE (%pM)' due to age (%ums).\n",
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:         LIBIPW_DEBUG_WX("Setting key %d to '%*pE' (%d:%d bytes)\n",
   drivers/net/wireless/intersil/hostap/hostap_proc.c:     seq_printf(m, "%*pE", (int)bss->ssid_len, bss->ssid);
   drivers/net/wireless/marvell/libertas/cfg.c:                    lbs_deb_scan("scan: %pM, capa %04x, chan %2d, %*pE, %d dBm\n",
   drivers/net/wireless/marvell/libertas/mesh.c:   lbs_deb_cmd("mesh config action %d type %x channel %d SSID %*pE\n",
   drivers/platform/olpc/olpc-xo175-ec.c:  dev_dbg(&priv->spi->dev, "got debug string [%*pE]\n",
   drivers/platform/surface/surface3_power.c:      snprintf(bix->serial, ARRAY_SIZE(bix->serial), "%3pE%6pE", buf + 7, buf);
   drivers/platform/surface/surface3_power.c:      snprintf(bix->OEM, ARRAY_SIZE(bix->OEM), "%3pE", buf);
   drivers/platform/x86/wmi.c:             pr_info("\tobject_id: %2pE\n", g->object_id);
   drivers/scsi/scsi_lib.c:                        id_size = snprintf(id, id_len, "t10.%*pE",
   drivers/soc/qcom/cmd-db.c:                      seq_printf(seq, "0x%05x: %*pEp", le32_to_cpu(ent->addr),
   drivers/staging/rtl8192e/rtllib.h:      snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
   drivers/staging/rtl8192u/ieee80211/ieee80211.h: snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);
   drivers/staging/wlan-ng/prism2sta.c:            netdev_info(wlandev->netdev, "Prism2 card SN: %*pE\n",
   drivers/thunderbolt/xdomain.c:  return sprintf(buf, "%*pE\n", (int)strlen(svc->key), svc->key);
   drivers/tty/mips_ejtag_fdc.c:           dev_dbg(priv->dev, "%s%u: out %08x: \"%*pE%*pE\"\n",
   drivers/tty/mips_ejtag_fdc.c:           dev_dbg(priv->dev, "%s%u: in  %08x: \"%*pE\"\n",
   drivers/tty/serial/serial_core.c:       pr_info("SysRq is enabled by magic sequence '%*pE' on serial\n",
   fs/overlayfs/overlayfs.h:       pr_debug("getxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
   fs/overlayfs/overlayfs.h:       pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
   lib/test_printf.c:      test("(null)", "%pE", NULL);
   lib/test_printf.c:      test("(efault)", "%pE", ERR_PTR(-11));
   lib/test_printf.c:      test("(efault)", "%pE", PTR_INVALID);
   net/ceph/debugfs.c:             seq_printf(s, "%*pE/%*pE\t0x%x",
   net/ceph/debugfs.c:             seq_printf(s, "%*pE\t0x%x", t->target_oid.name_len,

For all ESSID cases, there's no clear standard, but according to Cisco, double 
quote is illegal in SSID (although there's no formalised standard). At the very 
least it's extremely unusual, and even if it happens, I don't see how it could 
cause problems for the cases here.

- drivers/gpu/drm/drm_dp_cec.c: Device ID, chance of quotes is approaching zero.
- drivers/gpu/drm/drm_dp_dual_mode_helper.c: Debugging message only.
- drivers/gpu/drm/drm_dp_helper.c: Debugging message only.
- drivers/net/wireless/intel/ipw2x00/ipw2100.c: ESSID case, debugging message only.
- drivers/net/wireless/intel/ipw2x00/ipw2200.c: ESSID case, debugging message only.
- drivers/net/wireless/intersil/hostap/hostap_proc.c: ESSID case, /proc.
- drivers/net/wireless/marvell/libertas/cfg.c: ESSID case, debugging message only.
- drivers/net/wireless/marvell/libertas/mesh.c: ESSID case, debugging message only.
- drivers/platform/olpc/olpc-xo175-ec.c: Debugging message only.
- drivers/platform/surface/surface3_power.c: It wouldn't make sense for either the OEM or serial to contain quotes, especially considering how low level this is.
- drivers/platform/x86/wmi.c: Debug dump only, there's not gonna be quotes in 2 character escaping anyway.
- drivers/scsi/scsi_lib.c: Reading vendor ID. Passed back as length anyway, so that's fine -- it just needs to be unique.
- drivers/soc/qcom/cmd-db.c: Debug dump, and judging by the code no way it's gonna contain quotes.
- drivers/staging/rtl8192e/rtllib.h: ESSID case, only used for netdev_dbg messages anyway.
- drivers/staging/rtl8192u/ieee80211/ieee80211.h: Ditto rtllib.h.
- drivers/staging/wlan-ng/prism2sta.c: Serial number, it's not gonna contain quotes. For debugging only anyway.
- drivers/thunderbolt/xdomain.c: Used in key_show, which is used as a rare device_attribute. Only used for device debug.
- drivers/tty/mips_ejtag_fdc.c: Debugging messages only.
- drivers/tty/serial/serial_core.c: Debugging message only, and benefits from quoting (but seems highly unlikely it would be there anyway).
- fs/overlayfs/overlayfs.h: Debugging messages only, and would actually even benefit from the new quoting.
- lib/test_printf.c: None of these have quotes.
- net/ceph/debugfs.c: Debugging only, and looks unlikely to be affected regardless.
