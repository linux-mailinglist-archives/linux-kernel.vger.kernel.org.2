Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25E7409D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbhIMTi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbhIMTiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:38:55 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5779C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:37:38 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mPrlm-0005hm-0V; Mon, 13 Sep 2021 21:37:34 +0200
Date:   Mon, 13 Sep 2021 21:37:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] staging: r8188eu: power management cleanup
Message-ID: <20210913193733.nh5fijjo5jlsmqpk@viti.kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
 <YT96cYdbN/n5OY+S@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT96cYdbN/n5OY+S@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):

> On Sat, Sep 11, 2021 at 04:15:09PM +0200, Martin Kaiser wrote:
> > Remove some unused parts of the power management code.

> > Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.

> > Martin Kaiser (12):
> >   staging: r8188eu: btcoex_rfon is always false
> >   staging: r8188eu: setting HW_VAR_SET_RPWM does nothing
> >   staging: r8188eu: remove write-only variable cpwm
> >   staging: r8188eu: remove write-only variable tog
> >   staging: r8188eu: remove rtw_set_rpwm
> >   staging: r8188eu: remove unused power state defines
> >   staging: r8188eu: _free_pwrlock is empty
> >   staging: r8188eu: remove unused pwrctrl definitions
> >   staging: r8188eu: remove unused enum and array
> >   staging: r8188eu: rtw_set_ips_deny is not used
> >   staging: r8188eu: remove unused variable cpwm_tog
> >   staging: r8188eu: remove unused variable b_hw_radio_off

> I applied a subset of these.  Please rebase and resend the reset.

I sent a v2 of this patchset with the outstanding patches as a followup
to this set. I hope that this is generally the right thing to do after
the maintainer applies some patches of a set.

Thanks & best regards,
Martin
