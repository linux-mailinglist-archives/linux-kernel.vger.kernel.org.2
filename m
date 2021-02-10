Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285823160E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhBJIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhBJIXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:23:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9B4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:22:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gb24so691947pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AnB71wxQaaj1DZCEfr1ClX/e8caxjStydgZpaceaxuc=;
        b=ZwsxXoH+I21Niwd2GH7mvqLmE4PgFKT706cHiWvBvF0gMDV8ViHrNNArx3wqwm87nS
         j+fkvZSPuz4P4KzoF6h7uaYeCpuynzrQ9jUtNMLFEWZRcxzjsXlz0+cl2NWAICXzqwQ2
         UNaMtCXCIlVy4lbq6eyH/JwlrmSSs0uBrqiqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AnB71wxQaaj1DZCEfr1ClX/e8caxjStydgZpaceaxuc=;
        b=n8ovkfjEtIDIFq9nXqTUp/L82I3GKqwN1WK58VdIGRJ7RBbIVZfziERoWObkJ1/DgO
         zRCgKqAyGIc2/kniGT4uV1CrFcXqpCxv5hC4aK7Syyysh4pZ8OkH88EIrxlmnBD1xpGU
         r7UO8MbVOmiCarjNospZk7f/8xWCtsbkmQnBdvoaj7iFXNKi4Ii+5Lw70NKkhacWZbdh
         6qq5VAxpRhmyPh3kdXeKyhXhzk1gEQxqiVIe7lAMyBGugfyTaswjbzS+41VTi2+l0+Ix
         WT/FTp+DJgxO9uqE+xU3GXu4h+hRUr9Icle3RDaE9FDc07ImaeTm9jBzceMJ3tPw5uQ1
         l8PA==
X-Gm-Message-State: AOAM530MxqP7kUZngC8R/5wHlQDO80oGRmPt3xVvQmmGSiTF6le15rpV
        0OTX3IqjXJvtM/ieYHU0xVfutw==
X-Google-Smtp-Source: ABdhPJzIGQLD9dMHxNbPgPsTDYr263svJeW+Kb7bbTyQOqEluZfEPjRU2Pe/q/V9GXPgemoOfAIs2Q==
X-Received: by 2002:a17:902:8342:b029:e1:1465:4bf0 with SMTP id z2-20020a1709028342b02900e114654bf0mr2015644pln.76.1612945357471;
        Wed, 10 Feb 2021 00:22:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v26sm1287767pff.195.2021.02.10.00.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:22:36 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:22:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Message-ID: <202102092344.22A86166@keescook>
References: <20201217235615.43328-1-helgaas@kernel.org>
 <3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e21b6e87e219d6538a193a9021b965fd8180025.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:50:41PM -0800, Joe Perches wrote:
> On Thu, 2020-12-17 at 17:56 -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > as lore.kernel.org because they use different styles, add advertising, and
> > may disappear in the future.  The lore archives are more consistent and
> > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > they exist.
> 
> Hi Bjorn.
> 
> I like the idea, thanks, but a couple notes.
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -564,6 +564,17 @@ sub find_standard_signature {
> >  	return "";
> >  }
>  
> > +our $obsolete_archives = qr{(?xi:
> > +	freedesktop.org/archives/dri-devel|
> > +	lists.infradead.org|
> > +	lkml.org|
> > +	mail-archive.com|
> > +	mailman.alsa-project.org/pipermail|
> > +	marc.info|
> > +	ozlabs.org/pipermail|
> > +	spinics.net
> > +)};
> 
> Strictly, these all need \Q \E escaping so uses like lkmlAorg do not match.
> 
> 
> > @@ -3101,6 +3112,12 @@ sub process {
> >  			}
> >  		}
> >  
> > +# Check for mailing list archives other than lore.kernel.org
> > +		if ($line =~ /(http|https):\/\/\S*$obsolete_archives/) {
> 
> The https?:// doesn't seem necessary.  Perhaps:
> 
> 		if ($line =~ m{\b$obsolete_archives}) {
> 
> > +			WARN("PREFER_LORE_ARCHIVE",
> > +			     "Use lore.kernel.org archive links when possible; see https://lore.kernel.org/lists.html\n" . $herecurr);
> 
> Perhaps:
> 			     "Prefer lore.kernel.org links. see: https://www.kernel.org/lore.html#linking-to-list-discussions-from-commits\n" . $herecurr);
> 
> So maybe instead:
> ---
>  scripts/checkpatch.pl | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 00085308ed9d..c2a324d628a6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -564,6 +564,17 @@ sub find_standard_signature {
>  	return "";
>  }
>  
> +our $obsolete_archives = qr{(?xi:
> +	\Qfreedesktop.org/archives/dri-devel\E |
> +	\Qlists.infradead.org\E |
> +	\Qlkml.org\E |
> +	\Qmail-archive.com\E |
> +	\Qmailman.alsa-project.org/pipermail\E |
> +	\Qmarc.info\E |
> +	\Qozlabs.org/pipermail\E |
> +	\Qspinics.net\E
> +)};
> +
>  our @typeListMisordered = (
>  	qr{char\s+(?:un)?signed},
>  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> @@ -3101,6 +3112,12 @@ sub process {
>  			}
>  		}
>  
> +		# Check for mailing list archives other than lore.kernel.org
> +		if ($rawline =~ m{\b$obsolete_archives}) {
> +			WARN("PREFER_LORE_ARCHIVE",
> +			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
> +		}
> +
>  # Check for added, moved or deleted files
>  		if (!$reported_maintainer_file && !$in_commit_log &&
>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> 
> 

Ah, nice. Yes, this would be great to get added. Joe, can you respin as
a full path? Please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
