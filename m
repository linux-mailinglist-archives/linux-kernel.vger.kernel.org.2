Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D303A718B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhFNVtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:49:51 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:52634 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhFNVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:49:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 2BDCE2E2;
        Mon, 14 Jun 2021 23:47:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WNKugrCMqcPX; Mon, 14 Jun 2021 23:47:43 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 0A19490;
        Mon, 14 Jun 2021 23:47:42 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1lsuQn-008DZQ-LV; Mon, 14 Jun 2021 23:47:41 +0200
Date:   Mon, 14 Jun 2021 23:47:41 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        jani.nikula@linux.intel.com, gene@collinsnet.net,
        w.d.hubbs@gmail.com, steve.holmes88@gmail.com,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs: Convert the Speakup guide to rst
Message-ID: <20210614214741.enkzldkcug66ikym@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        jani.nikula@linux.intel.com, gene@collinsnet.net,
        w.d.hubbs@gmail.com, steve.holmes88@gmail.com,
        speakup@linux-speakup.org, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        chris@the-brannons.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210607132914.20480-1-igormtorrente@gmail.com>
 <87r1h415mk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1h415mk.fsf@meer.lwn.net>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 2BDCE2E2
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
         RCPT_COUNT_TWELVE(0.00)[13];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[gmail.com];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet, le lun. 14 juin 2021 15:46:43 -0600, a ecrit:
> Igor Matheus Andrade Torrente <igormtorrente@gmail.com> writes:
> 
> > v4: Reverts the licensing change to a dual-licensing
> >     'GPL-2.0 OR GFDL-1.2-no-invariants-or-later'.
> >
> >     And, therefore, this patch should only be accepted when we have
> >     all acks from the copyright owners.
> 
> What's the status of that?  I'd like to get this work merged for 5.14 if
> possible...

We are still waiting for some author ack on the licence change.

Samuel
