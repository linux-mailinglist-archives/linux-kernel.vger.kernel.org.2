Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C575316D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhBJRq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhBJRqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:46:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C828064ECF;
        Wed, 10 Feb 2021 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612979153;
        bh=/rkL6c7UoMWbGrEXcVkr8WWkfNnRE92JsX1y12GRzlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j9oRyJb527+OyWGu4R2BzKyCISXpXASfncMwp4fdNMDqWYxKFpTkMsZSz1iYwekUq
         iM0myjP6HhdtKgGeSFtzjMuxuJyDyUffW0+TbM2en+2Lt5SX7F5u5gA4dfabzdA5wx
         DUqFwP1sFRR/Mai5nlzP+Q55TBwOWNQToi52HuPEFXAqXayNC0uak/R33OE3gsfrlD
         7MHeTlz8Kk2M5QSFEZABQlRuBI8u2oqpsn1eW4kLqJ+CmHeu+F/toVZNz7jJE5qhdJ
         BdJ3L5QaSMzmXHTKBR+4U8uV8OwAkUKAhXlmtGCtH8CdCKFmp5Uclyk+ROBWZVuV+K
         1/gNlr9wzu/QQ==
Date:   Wed, 10 Feb 2021 11:45:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Message-ID: <20210210174551.GA593525@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202102092344.22A86166@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:22:35AM -0800, Kees Cook wrote:
> On Thu, Dec 17, 2020 at 04:50:41PM -0800, Joe Perches wrote:
> > On Thu, 2020-12-17 at 17:56 -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> > > as lore.kernel.org because they use different styles, add advertising, and
> > > may disappear in the future.  The lore archives are more consistent and
> > > more likely to stick around, so prefer https://lore.kernel.org URLs when
> > > they exist.
> > 
> > Hi Bjorn.
> > 
> > I like the idea, thanks, but a couple notes.
> > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -564,6 +564,17 @@ sub find_standard_signature {
> > >  	return "";
> > >  }
> >  
> > > +our $obsolete_archives = qr{(?xi:
> > > +	freedesktop.org/archives/dri-devel|
> > > +	lists.infradead.org|
> > > +	lkml.org|
> > > +	mail-archive.com|
> > > +	mailman.alsa-project.org/pipermail|
> > > +	marc.info|
> > > +	ozlabs.org/pipermail|
> > > +	spinics.net
> > > +)};
> > 
> > Strictly, these all need \Q \E escaping so uses like lkmlAorg do not match.
> > 
> > 
> > > @@ -3101,6 +3112,12 @@ sub process {
> > >  			}
> > >  		}
> > >  
> > > +# Check for mailing list archives other than lore.kernel.org
> > > +		if ($line =~ /(http|https):\/\/\S*$obsolete_archives/) {
> > 
> > The https?:// doesn't seem necessary.  Perhaps:
> > 
> > 		if ($line =~ m{\b$obsolete_archives}) {
> > 
> > > +			WARN("PREFER_LORE_ARCHIVE",
> > > +			     "Use lore.kernel.org archive links when possible; see https://lore.kernel.org/lists.html\n" . $herecurr);
> > 
> > Perhaps:
> > 			     "Prefer lore.kernel.org links. see: https://www.kernel.org/lore.html#linking-to-list-discussions-from-commits\n" . $herecurr);
> > 
> > So maybe instead:
> > ---
> >  scripts/checkpatch.pl | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 00085308ed9d..c2a324d628a6 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -564,6 +564,17 @@ sub find_standard_signature {
> >  	return "";
> >  }
> >  
> > +our $obsolete_archives = qr{(?xi:
> > +	\Qfreedesktop.org/archives/dri-devel\E |
> > +	\Qlists.infradead.org\E |
> > +	\Qlkml.org\E |
> > +	\Qmail-archive.com\E |
> > +	\Qmailman.alsa-project.org/pipermail\E |
> > +	\Qmarc.info\E |
> > +	\Qozlabs.org/pipermail\E |
> > +	\Qspinics.net\E
> > +)};
> > +
> >  our @typeListMisordered = (
> >  	qr{char\s+(?:un)?signed},
> >  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> > @@ -3101,6 +3112,12 @@ sub process {
> >  			}
> >  		}
> >  
> > +		# Check for mailing list archives other than lore.kernel.org
> > +		if ($rawline =~ m{\b$obsolete_archives}) {
> > +			WARN("PREFER_LORE_ARCHIVE",
> > +			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
> > +		}
> > +
> >  # Check for added, moved or deleted files
> >  		if (!$reported_maintainer_file && !$in_commit_log &&
> >  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> > 
> > 
> 
> Ah, nice. Yes, this would be great to get added. Joe, can you respin as
> a full path? Please consider it:

I hate to ask Joe to rework *my* patch just because I've dropped the
ball on it!  Sorry, I'll try to resurrect this.

> Reviewed-by: Kees Cook <keescook@chromium.org>
