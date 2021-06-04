Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7639B20A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFDFgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhFDFgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:36:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C5686140F;
        Fri,  4 Jun 2021 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622784890;
        bh=CZRsTARUFf+bfqnIsqTxlZDBGyP7XKDxDCRAdZ6HnyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzrVJvrpCMIDOL0flT0eW++HPr+d/QVBaiNcCRghhb5/iIKz+cc7VswXUXXUdWHqx
         5a9WZ6C9mb/xXe/ZqI0cYwVuE5LiS+fxSiK8ZU7izH1tRjbkwPdfWEzxupFfwsHLT0
         l1a3PXxAzjOGbnuiY/6GyECIhqvxwGzd2PjyQ25l1K7MZJh8pD9FHUsRwy+MYw1ZC4
         eCzYW1rtX5nACkrJGgPe1JB8Au72B5OgB+L/1BZYhwHobui9WgNxhjH1AIaD0OtvLV
         7WyaJ6cz9qEkAEVH9Y/MY+elf2gexdeTmwR5T5BOVEgYxdrxXMmwIASMtJHAB40SUh
         eMuN+VeD6Oo0Q==
Date:   Thu, 3 Jun 2021 22:34:48 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: clean up /sys/fs/f2fs/<disk>/features
Message-ID: <YLm7eCBkwuU0cZws@google.com>
References: <20210603220834.1949988-1-jaegeuk@kernel.org>
 <YLmvIH/wVeKwSPCN@google.com>
 <YLm12A7qKFyYYU0Z@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLm12A7qKFyYYU0Z@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03, Eric Biggers wrote:
> On Thu, Jun 03, 2021 at 09:42:08PM -0700, Jaegeuk Kim wrote:
> >  enum feat_id {
> >  	FEAT_CRYPTO = 0,
> >  	FEAT_BLKZONED,
> > @@ -587,6 +601,7 @@ enum feat_id {
> >  	FEAT_RO,
> >  	FEAT_TEST_DUMMY_ENCRYPTION_V2,
> >  	FEAT_ENCRYPTED_CASEFOLD,
> > +	FEAT_PIN_FILE,
> >  };
> >  
> >  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> > @@ -610,6 +625,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> >  	case FEAT_RO:
> >  	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
> >  	case FEAT_ENCRYPTED_CASEFOLD:
> > +	case FEAT_PIN_FILE:
> >  		return sprintf(buf, "supported\n");
> >  	}
> >  	return 0;
> 
> There's no need for the feat_id enum to exist.  If f2fs_feature_show() just
> always printed "supported\n", it will do the right thing.

Done.

> 
> Also, adding pin_file probably should be a separate patch.  That seems to be a
> bug fix, as pin_file was mistakenly added to the per-sb feature list instead of
> to the kernel feature list?

Done.

> 
> > +static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
> > +		struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +	if (F2FS_MATCH_FEATURE(sbi, a->id))
> > +		return sprintf(buf, "supported\n");
> > +	return sprintf(buf, "unsupported\n");
> > +}
> 
> This can just use F2FS_HAS_FEATURE(), provided that encrypted_casefold isn't
> included here, which it shouldn't be (as discussed elsewhere).

I know, but I think it'd be good to sync with kernel feature.

> 
> - Eric
