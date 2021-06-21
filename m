Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD243AEA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFUNhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:37:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFUNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:37:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1ED621A62;
        Mon, 21 Jun 2021 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624282492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wq61hA8VpK15+asqyxgoJBgQRR/UMP1AaeemXMhFQn4=;
        b=EiiKPNVnJASX3uoJD+RlXYMcoiifKWJ0oT8akppe07HJGisIGcv2fpr8ox4rb6LdL6F+Wh
        glTGZ2aloxH9vkYtfrtqZiqZeF6cXmzMEDKsPoBoAKCzxnRcZDz/ouDIWR8SXBKJ2FoQVj
        zKtB9lOH8kHSAqYmGwx3OTPWDAPNkMs=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4AC69118DD;
        Mon, 21 Jun 2021 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624282492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wq61hA8VpK15+asqyxgoJBgQRR/UMP1AaeemXMhFQn4=;
        b=EiiKPNVnJASX3uoJD+RlXYMcoiifKWJ0oT8akppe07HJGisIGcv2fpr8ox4rb6LdL6F+Wh
        glTGZ2aloxH9vkYtfrtqZiqZeF6cXmzMEDKsPoBoAKCzxnRcZDz/ouDIWR8SXBKJ2FoQVj
        zKtB9lOH8kHSAqYmGwx3OTPWDAPNkMs=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id NKRLEHyV0GAJVAAALh3uQQ
        (envelope-from <oneukum@suse.com>); Mon, 21 Jun 2021 13:34:52 +0000
Message-ID: <6122b97bb4a30a917b16837e8f98b6aac69f897a.camel@suse.com>
Subject: Re: [PATCH] usb: class: cdc-wdm: return the correct errno code
From:   Oliver Neukum <oneukum@suse.com>
To:     Junlin Yang <angkery@163.com>, gregkh@linuxfoundation.org,
        penguin-kernel@i-love.sakura.ne.jp, loic.poulain@linaro.org,
        davem@davemloft.net, lee.jones@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
Date:   Mon, 21 Jun 2021 15:34:51 +0200
In-Reply-To: <20210621132415.2341-1-angkery@163.com>
References: <20210621132415.2341-1-angkery@163.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 21.06.2021, 21:24 +0800 schrieb Junlin Yang:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> The "rv" is initialized to "-ENOMEM", because "rv" is re-assigned to
> "-EINVAL", when kmalloc & usb_alloc_urb failed, the return value
> should
> return "-ENOMEM" rather than "-EINVAL",so the "rv" assignment is
> placed
> in the position where usb_endpoint_is_int_in is false.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

