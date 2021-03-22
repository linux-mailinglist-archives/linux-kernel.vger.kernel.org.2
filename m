Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA54E343E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhCVKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:47:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:57302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhCVKqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:46:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616410011; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yNCFb4Q6Lo3zYRcU+M6ZFQvE2IaGV7stSEkjTFgXh4=;
        b=UXergoAXFvVL7war+ylFwgG5IRPq3EYKxgiIdxs62JISIRqQe0OYj0GOpr9OvxcR/ETUqS
        Y2S5fPegIb2Zd3WSxyg8pt9sttQmXlD00u/lfbQLBX5bwSNNZS5Cuta20yO6vGyOudIHna
        avC79VEwYyFkNz7/fB8toF602aeEqPs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 083CFAD79;
        Mon, 22 Mar 2021 10:46:51 +0000 (UTC)
Message-ID: <9a802d1120a03e34d0e40e1d4e1e558c5359e92b.camel@suse.com>
Subject: Re: [PATCH 7/7] USB: cdc-acm: always claim data interface
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Mar 2021 11:46:47 +0100
In-Reply-To: <20210318155202.22230-8-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
         <20210318155202.22230-8-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 18.03.2021, 16:52 +0100 schrieb Johan Hovold:
> Make sure to always claim the data interface and bail out if it's
> already bound to another driver or isn't authorised.

Hi,

Thanks for the fixes. All previous ones are good work.
this one is problematic I am afraid.


acm_probe() has a test for the availability of the interface:

	if (!combined_interfaces && usb_interface_claimed(data_interface)) {
		/* valid in this context */
		dev_dbg(&intf->dev, "The data interface isn't available\n");
		return -EBUSY;
	}

That check is ancient. BKL still existed. If you want to remove it
and do proper error handling, that would be good. But if you do
error handling, the check has to go, too.

	Regards
		Oliver


