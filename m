Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDB631ED03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhBRRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:12:43 -0500
Received: from fgw21-4.mail.saunalahti.fi ([62.142.5.108]:65460 "EHLO
        fgw21-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232319AbhBROe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:34:57 -0500
X-Greylist: delayed 1088 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2021 09:34:56 EST
Received: from toshiba (85-156-79-75.elisa-laajakaista.fi [85.156.79.75])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
        id b7901546-71f3-11eb-9eb8-005056bdd08f;
        Thu, 18 Feb 2021 16:15:14 +0200 (EET)
Message-ID: <602E766F.758C74D8@users.sourceforge.net>
Date:   Thu, 18 Feb 2021 16:15:11 +0200
From:   Jari Ruusu <jariruusu@users.sourceforge.net>
MIME-Version: 1.0
To:     Willy Tarreau <w@1wt.eu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
         <YA/E1bHRmZb50MlS@kroah.com>
         <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
         <YBBkplRxzzmPYKC+@kroah.com>
         <YCzknUTDytY8gRA8@kroah.com>
         <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
         <YC4atKmK7ZqlOGER@kroah.com> <20210218113107.GA12547@1wt.eu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> The only set of fixes that can be trusted are the "official" stable
> kernels, because they are the only ones that are approved by the patches
> authors themselves. Adding more stuff on top of stable kernels is fine
> (and done at your own risk), but randomly dropping stuff from stable
> kernels just because you don't think you need that is totally non-sense
> and must not be done anymore!

This may be little bit off-topic... but stable kernel.org kernels
can also bit-rot badly because of "selective" backporting... as in
anything that does not apply cleanly gets dropped regardless of
how critical they are.

I will give you one example: Intel WiFi (iwlwifi) on 4.19.y
kernel.org stable kernels is currently missing many critical
locking fixes. As a result, that in-tree iwlwifi driver causes
erratic behavior to random unrelated processes, and has been doing
so for many months now. My not-so-politically correct opinion is
that in-tree iwlwifi is completely FUBAR unless someone steps up
to do professional quality backport of those locking fixes from
upstream out-of-tree Intel version [1] [2] of the driver. For me
only way to get properly working WiFi on my laptop computer is to
compile that Intel out-of-tree version. Sad, but true.

[1] https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/core_release
[2] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
