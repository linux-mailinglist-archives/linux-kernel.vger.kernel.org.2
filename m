Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D7B397BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhFAWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:00:30 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:49626 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhFAWA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:00:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 88CC131F;
        Tue,  1 Jun 2021 23:58:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3uddWn2Mdui3; Tue,  1 Jun 2021 23:58:45 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id BE0A1233;
        Tue,  1 Jun 2021 23:58:44 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1loCPM-005VoO-0T; Tue, 01 Jun 2021 23:58:44 +0200
Date:   Tue, 1 Jun 2021 23:58:44 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Igor Torrente <igormtorrente@gmail.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
Message-ID: <20210601215843.ajebgifrgm2mth5t@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Igor Torrente <igormtorrente@gmail.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <87r1hlrfhk.fsf@intel.com>
 <1b1e0e07-d438-0902-a28a-e346cba53518@gmail.com>
 <878s3tr3ai.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s3tr3ai.fsf@intel.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 88CC131F
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[gmail.com];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Nikula, le mar. 01 juin 2021 18:51:49 +0300, a ecrit:
> On Tue, 01 Jun 2021, Igor Torrente <igormtorrente@gmail.com> wrote:
> > There's a way to do that without these blank lines?
> >
> > For me, it doesn't look very good, but I think the tradeoff worth it 
> > improves readability to speakup users. If it is the case.
> 
> I was thinking:
> 
> acntsa
>   Accent SA
> 
> acntpc
>   Accent PC
> 
> apollo
>   Apollo

Having the two pieces on separate lines makes it a bit more tedious to
read on Braille displays, it's better to keep them single-line.

> >>> +
> >>> +.. note::
> >>> +
> >>> +   | Speakup does **NOT** support usb connections!
> >>> +   | Speakup also does **NOT** support the internal Tripletalk!
> >> 
> >> Why the pipes "|"?
> >
> > This is the way I found to separate these sentences into two different 
> > lines. I'm gladly accepting a better solution for this :)
> 
> Maybe just like this?
> 
> .. note::
> 
>    Speakup does **NOT** support usb connections!
> 
>    Speakup also does **NOT** support the internal Tripletalk!

That will be fine (though the first statement is actually outdated)

Samuel
