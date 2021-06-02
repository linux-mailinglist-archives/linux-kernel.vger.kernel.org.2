Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B04398375
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhFBHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:47:52 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57178 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhFBHrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:47:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 1A2C94AE;
        Wed,  2 Jun 2021 09:46:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TJGLL8MI3RHF; Wed,  2 Jun 2021 09:45:59 +0200 (CEST)
Received: from begin (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 24A2842B;
        Wed,  2 Jun 2021 09:45:55 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1loKdk-0063uT-3T; Wed, 02 Jun 2021 08:46:08 +0200
Date:   Wed, 2 Jun 2021 08:46:03 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Chris Brannon <chris@the-brannons.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        William Hubbs <w.d.hubbs@gmail.com>,
        collins@gene3.ait.iastate.edu,
        Steve Holmes <steve.holmes88@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
Message-ID: <20210602064603.hlluahbkc2ncull3@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <87r1hldli1.fsf@the-brannons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1hldli1.fsf@the-brannons.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 1A2C94AE
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[11];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Chris Brannon, le mar. 01 juin 2021 19:54:30 -0700, a ecrit:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> 
> > So we'd need Gene's, Christopher's, William's, and Steve's ack on adding
> > the GPL alternative to the GFDL-1.2 licence.
> 
> You have my ack.  Do whatever is needful.  I wish I didn't have to care about
> this stuff.

Thanks! Linux will stay GPL forever anyway so that will do for
long-term.

Samuel
