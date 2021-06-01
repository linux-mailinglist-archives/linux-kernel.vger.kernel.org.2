Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A67397CAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhFAWuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhFAWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:50:40 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBEBC06174A;
        Tue,  1 Jun 2021 15:48:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 2B6A6CD2;
        Wed,  2 Jun 2021 00:48:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xhGtF0-e1zUt; Wed,  2 Jun 2021 00:48:55 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 357C8CB8;
        Wed,  2 Jun 2021 00:48:55 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1loDBu-005Wz6-2x; Wed, 02 Jun 2021 00:48:54 +0200
Date:   Wed, 2 Jun 2021 00:48:54 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     speakup@linux-speakup.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Christopher Brannon <chris@the-brannons.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Steve Holmes <steve.holmes88@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
Message-ID: <20210601224854.iug2arwes64k7fxr@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, Jonathan Corbet <corbet@lwn.net>,
        Christopher Brannon <chris@the-brannons.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
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
 <20210601224452.sqblwctwiu47xgqg@begin>
 <20210601224554.6kc5syoy2tscisiv@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601224554.6kc5syoy2tscisiv@begin>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 2B6A6CD2
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

Samuel Thibault wrote:
> > - The initial import of the file (bddef0d280cd) wears only the Gene
> >   Collins copyright notice.
> 
> I'm here fixing the mail for Chris and Gene with an up-to-date email
> address, I also bounced them my previous mail.

Mmm, no, acollins@icsmail.net is not working either. Does anybody on the
speakup mailing list know an up-to-date mail address for Gene?

Samuel
