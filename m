Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C38397C78
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhFAWjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:39:33 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:50244 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhFAWja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:39:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id F0E49899;
        Wed,  2 Jun 2021 00:37:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xtQRWJTpljHk; Wed,  2 Jun 2021 00:37:45 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id EE20E170;
        Wed,  2 Jun 2021 00:37:44 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1loD15-005WbP-QT; Wed, 02 Jun 2021 00:37:43 +0200
Date:   Wed, 2 Jun 2021 00:37:43 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Christopher Brannon <cmbrannon@cox.net>,
        William Hubbs <w.d.hubbs@gmail.com>,
        collins@gene3.ait.iastate.edu,
        Steve Holmes <steve.holmes88@gmail.com>
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
Message-ID: <20210601223743.carif4gkzcz5jo7j@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Christopher Brannon <cmbrannon@cox.net>,
        William Hubbs <w.d.hubbs@gmail.com>, collins@gene3.ait.iastate.edu,
        Steve Holmes <steve.holmes88@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <875yyxbenm.fsf@meer.lwn.net>
 <20210601220643.uzep2ju2zlcmpa57@begin>
 <874keh9qk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874keh9qk9.fsf@meer.lwn.net>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: F0E49899
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[cox.net,gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[11];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[gmail.com];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet, le mar. 01 juin 2021 16:18:46 -0600, a ecrit:
> The problem is that the kernel docs, when built, include a great deal of
> code and text taken directly from the kernel source.  The built docs are
> thus a derived product of the kernel and the result needs to carry a
> GPL-compatible license.

Ah...

> I've spent some time talking with lawyers about
> this, and they have confirmed that view of things.

Yes, sure.

> As a standalone .txt file there is probably no legal problem, but that
> changes as soon as you bring it into RST TOC tree.

Yes.

> >> What are the chances that we can get the authors to agree on a change to
> >> a GPL-compatible license for this file?
> >
> > I don't know about Collins' opinion on this, Cc-ing him with the latest
> > mail my archives know for him (which dates 2008...)
> >
> > The copyright "the Speakup Team" is a more complex thing to look for.
> 
> Do you have a history of contributors to the file in its previous home?

Checking more closely, it seems we have it. The detail is in
git@github.com:linux-speakup/speakup.git in ./doc/spkguide.txt, but that
seems relatively simple:

- The initial import of the file (bddef0d280cd) wears only the Gene
  Collins copyright notice.
- I made some changes and added my copyright notice.
- Christopher Brannon (now in Cc) made various changes and added the
  "the Speakup Team" copyright notice.
- William Hubbs (now in Cc) made some changes.
- Steve Holmes (now in Cc) added one sentence.

So we'd need Gene's, Christopher's, William's, and Steve's ack on adding
the GPL alternative to the GFDL-1.2 licence.

Samuel
