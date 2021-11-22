Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80120458C15
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhKVKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:12:23 -0500
Received: from smtp1.axis.com ([195.60.68.17]:13597 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhKVKMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1637575756;
  x=1669111756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yJ5js0/XIZRubAMn4hN5cNt6fkJH1M2AaXvq/+uvKlw=;
  b=HsYn6nPzyVqEqq4gwNkfLbrtqort5XVnMvgoJiPrEa64AEAlN7PZoDmA
   YQAJtqQD85TwDCBr08wrNiwW1uNmNZNykaRebcTgVHCKNmMXgebndAlj2
   CsRVeJUQ2NWKeYyy/trNDWoslBBjSFetVqcojJtjSUM9p3PWq3LC9kBnC
   HOyzx0OY4yh8Zq1DrAHt+YgYkxLA+J0izmhhuWBQgUUg1siqN2PbfX3tD
   Q6YqmUGXNlcyN5yEPxcAcXwBKmL0CVP5EhnGhS3PMfozxGWymEWd0GU0p
   INsfDGImkI0qUV98gNbE3Qsq3HPahAGZvqAEGf/uxJ5vYBgn3MTIcvJhu
   Q==;
Date:   Mon, 22 Nov 2021 11:09:14 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, kernel <kernel@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: uaccess: fix put_user() with TTBR0 PAN
Message-ID: <20211122100914.GA30695@axis.com>
References: <20211118163417.21617-1-vincent.whitchurch@axis.com>
 <20211119130419.GA25912@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211119130419.GA25912@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 02:04:50PM +0100, Mark Rutland wrote:
> I think it would be better to use temporaries in __raw_put_user(), along
> with a comment there, so that the requirement is documented and dealt
> with in once place. Example diff at the end of this mail; I'm happy for
> you to pick that for v2, or I can send it out as a patch if your prefer.

Please feel free to send it out as a patch.  Thank you.
