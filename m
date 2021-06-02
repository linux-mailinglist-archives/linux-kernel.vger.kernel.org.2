Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB23983C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhFBICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:02:55 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57574 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhFBICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:02:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 3F5A628C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:00:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n9a6q-CQwnge for <linux-kernel@vger.kernel.org>;
        Wed,  2 Jun 2021 10:00:37 +0200 (CEST)
Received: from begin.home (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 68834F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:00:37 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1loKf3-0063x5-7N; Wed, 02 Jun 2021 08:47:29 +0200
Date:   Wed, 2 Jun 2021 08:47:24 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christopher Brannon <cmbrannon@cox.net>,
        William Hubbs <w.d.hubbs@gmail.com>,
        collins@gene3.ait.iastate.edu,
        Steve Holmes <steve.holmes88@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
Message-ID: <20210602064724.hzygl3qewillrlqr@begin>
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
 <20210601223743.carif4gkzcz5jo7j@begin>
 <87mts98aom.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mts98aom.fsf@meer.lwn.net>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 3F5A628C
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TAGGED_RCPT(0.00)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-kernel@vger.kernel.org];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[cox.net];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet, le mar. 01 juin 2021 16:47:05 -0600, a ecrit:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> 
> > So we'd need Gene's, Christopher's, William's, and Steve's ack on adding
> > the GPL alternative to the GFDL-1.2 licence.
> 
> That would be great.
> 
> One other thing that crosses my mind...we'll need to remove the GFDL
> license text as well.

Yes, sure the SPDX tag will be enough.

Samuel
