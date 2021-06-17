Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476B23AB2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhFQLuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232450AbhFQLuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:50:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7DF46140C;
        Thu, 17 Jun 2021 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623930477;
        bh=vjrcq7wCfXT7sKqqNCnrGMGicqBcnDXntV2ygtXG/NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCZY7atHCe8jfmIwx2t933jjY/7j8QuAu+a/78NPWn7QyyBfl2u8/ux0h3vcHXtlL
         Gis0sj1pYJ89I77dKxNggmcKiGS3+TrsIsc6/FgaQi2Iyb6FsLHQdXKJWigTOI5b/5
         oM5DaXRfDQ7nLgMLweK+eW8POV0P0HAYs9O9iPRM=
Date:   Thu, 17 Jun 2021 13:47:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next 2/2] mei: revamp mei extension header structure
 layout.
Message-ID: <YMs2a/RpqlcTad2O@kroah.com>
References: <20210615211557.248292-1-tomas.winkler@intel.com>
 <20210615211557.248292-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615211557.248292-2-tomas.winkler@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:15:57AM +0300, Tomas Winkler wrote:
> @@ -284,7 +296,7 @@ static inline bool mei_ext_last(struct mei_ext_meta_hdr *meta,
>  }
>  
>  /**
> - *mei_ext_next - following extended header on the TLV list
> + * mei_ext_next - following extended header on the TLV list
>   *
>   * @ext: current extend header
>   *

This change belongs in the previous patch, not this one.

Please fix up.

thanks,

greg k-h
