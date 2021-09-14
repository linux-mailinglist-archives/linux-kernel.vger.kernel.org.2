Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1340B621
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhINRoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:44:06 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45607 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhINRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:44:05 -0400
Received: (Authenticated sender: peter@casa-korsgaard.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 803B8100006;
        Tue, 14 Sep 2021 17:42:45 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1mQCSC-00070f-Qn; Tue, 14 Sep 2021 19:42:44 +0200
X-From-Line: nobody Tue Sep 14 14:03:52 2021
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove dead e-mails
References: <20210914092603.18722-1-jslaby@suse.cz>
Date:   Tue, 14 Sep 2021 14:03:52 +0200
In-Reply-To: <20210914092603.18722-1-jslaby@suse.cz> (Jiri Slaby's message of
        "Tue, 14 Sep 2021 11:26:03 +0200")
Message-ID: <874kan5pp3.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Lines:  27
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jiri" == Jiri Slaby <jslaby@suse.cz> writes:

 > jacmet@sunsite.dk and linux@prisktech.co.nz are dead:
 > * This is the qmail-send program at a.mx.sunsite.dk.
 >   <jacmet@sunsite.dk>:
 >   Sorry, no mailbox here by that name. (#5.1.1)
 > * 4.1.2 <linux@prisktech.co.nz>: Recipient address rejected: Domain not
 >   found

 > Remove them from MAINTAINERS.

 > CCing Peter with his (different) e-mail, he likely wants to update?

Ahh yes, it should be changed to peter@korsgaard.com


 >  USB CYPRESS C67X00 DRIVER
 > -M:	Peter Korsgaard <jacmet@sunsite.dk>
 >  L:	linux-usb@vger.kernel.org
 >  S:	Maintained
 >  F:	drivers/usb/c67x00/

I haven't had access to c67x00 hw for quite some years though, so maybe
it should be marked Orphan instead?

-- 
Bye, Peter Korsgaard
