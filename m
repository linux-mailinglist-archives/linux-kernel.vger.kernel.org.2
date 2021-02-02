Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F384E30BEAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhBBMtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:49:18 -0500
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:46742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231722AbhBBMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:48:49 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 32074181D2FD2;
        Tue,  2 Feb 2021 12:48:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3834:3865:3866:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7652:9010:9025:10004:10400:10848:11232:11658:11914:12043:12114:12297:12555:12696:12737:12740:12760:12895:12986:13069:13095:13161:13229:13311:13357:13439:13845:14181:14659:14721:21080:21433:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cream87_430f2d4275cb
X-Filterd-Recvd-Size: 1902
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Feb 2021 12:48:05 +0000 (UTC)
Message-ID: <d5277573215624098109e888c01f4b10fa917439.camel@perches.com>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch
 help?
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Date:   Tue, 02 Feb 2021 04:48:04 -0800
In-Reply-To: <CABJPP5Dt6KyoaMr-dS9425rozKoCyiPgx9WfoeY2541Aq3MF=w@mail.gmail.com>
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
         <YBguQ/dENrfvtptJ@kroah.com>
         <CAKXUXMwtXTYfs_9Asnmpd09zsucg8tRehMi2Shv8V49H-rs4xA@mail.gmail.com>
         <CABJPP5Dt6KyoaMr-dS9425rozKoCyiPgx9WfoeY2541Aq3MF=w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-02-01 at 22:41 +0530, Dwaipayan Ray wrote:
> The idea of a bot seems nice though in general.
> People do have all the style checking scripts at their disposal, but still
> we see style issues on the list.
> 
> Something similar to the kernel test robot, but for style issues seems nice.
> Is it something the community would like?

(Adding lkp)

Maybe yes, but likely it depends on the particular audience so
no, not really.

The kbuild test robot used to run checkpatch on patches and there
there was negative feedback.  I don't know if the robot is still
running checkpatch with some subset of message types.

A thread from 2013:

https://lore.kernel.org/lkml/20130903003958.GA6855@localhost/


