Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD83137B77D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhELIIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhELIIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62678613AA;
        Wed, 12 May 2021 08:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620806822;
        bh=/wL3cbl3cFF3X0mum4MDl0C5U3uLp1fyGeTScuk2dHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEQa4d4SFM+ch2zHFJL9PGktQBw21xtmAmL59zLDUzb4sfyki2+pEJjWRw5MUGTV3
         nLG27Su0YvoOVtb0q/M1t6T/Ah9AWc0eAOfvKsc0wBoHBxXhoTLFQz/fiIHyJlIe7E
         WevDkYtAbG68b9W78qEl/Yq3rxJfms48LBv8WM+8=
Date:   Wed, 12 May 2021 10:07:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guy Zadicario <guy.zadicario@intel.com>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net,
        alexander.shishkin@linux.intel.com, andriy.shevchenko@intel.com,
        yochai.shefi-simchon@intel.com
Subject: Re: [PATCH 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I pcie
 device
Message-ID: <YJuMpHmqQ150LBbJ@kroah.com>
References: <20210512071046.34941-1-guy.zadicario@intel.com>
 <YJuDUXennxtR5rCZ@kroah.com>
 <20210512075141.GA35140@aipg-stp-03.iil.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512075141.GA35140@aipg-stp-03.iil.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 10:51:41AM +0300, Guy Zadicario wrote:
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> 

Now deleted, this is not compatible with kernel development :(
