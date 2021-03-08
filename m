Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B240330AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCHJ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:57:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:53636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231479AbhCHJ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:57:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615197438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ox9pnNjIVFkayHN1+11ut1Jk/mZ9ayYn7+APO2/2Yos=;
        b=o+CCEZBUDxcQn0LkP3HHn6segidLYcBjRSZHuJZh7akDY3GA2dXo5d/QwG0Z9iWgwX0tf2
        I9ai6RmvXk5qwhE45U0kC/XrEncKmg9gSwLI6c88aZj47GUm0OL5VML+RdtKU2ntY3A6i/
        syDURdCGc3hd2fYQn+piRGwUeGuYEPc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 755EAACBF;
        Mon,  8 Mar 2021 09:57:18 +0000 (UTC)
Message-ID: <7ea20413bdb68f98430b3cfc8ac5824be26781af.camel@suse.com>
Subject: Re: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
From:   Oliver Neukum <oneukum@suse.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>
Date:   Mon, 08 Mar 2021 10:57:14 +0100
In-Reply-To: <CAH+2xPC0sbqvsiBgsemHxrmE=JgnuOK6mzJ6pQ_G-ihqswAvPQ@mail.gmail.com>
References: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
         <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com>
         <777991bb72f8842e3e730f9b600b2086478f5d36.camel@suse.com>
         <CAH+2xPAB4bWN9NiTQr4WggUX6eDXzMikzYJySx3sAj3Ho3AdxA@mail.gmail.com>
         <b71b85a588c3e27d2de129723468263d932ab435.camel@suse.com>
         <CAH+2xPA4yUwbcOaO4OH-LaAwC820ZoFmAf_eUdf6+xgiTPWz8g@mail.gmail.com>
         <CAH+2xPC0sbqvsiBgsemHxrmE=JgnuOK6mzJ6pQ_G-ihqswAvPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 08.03.2021, 09:50 +0100 schrieb Bruno Thomsen:
> 
> Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> 
> I have not observed any oops with patches applied. Patches have seen
> more than 10 weeks of runtime testing across multiple devices.

Hi,

that is good news. I shall send them upstream.

	Regards
		Oliver


