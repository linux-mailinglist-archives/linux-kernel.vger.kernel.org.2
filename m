Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055A9425B18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbhJGSrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:47:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:42604 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJGSro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:47:44 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 197Ihdq8011954;
        Thu, 7 Oct 2021 13:43:39 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 197IhbO3011953;
        Thu, 7 Oct 2021 13:43:37 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 7 Oct 2021 13:43:37 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf vendor events power10: Add metric events json file for power10 platform
Message-ID: <20211007184337.GN10333@gate.crashing.org>
References: <20211006073119.276340-1-kjain@linux.ibm.com> <20211006173248.GA7389@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com> <20211007134750.GA243632@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007134750.GA243632@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 08:47:50AM -0500, Paul A. Clarke wrote:
> On Wed, Oct 06, 2021 at 12:32:48PM -0500, Paul A. Clarke wrote:
> > > +    {
> > > +        "BriefDescription": "Average cycles per instruction when the instruction finishes at dispatch",
> > 
> > I'm not sure what that means.
> 
> After doing a bit of research, I think it might be a bit more clear as:
> "Average cycles per instruction when the NTF instruction finishes at dispatch"

Is "next to finish" some defined and/or sensible term in this context?
Or do you mean NTC here?  Or what :-)

Instructions do not finish in order at all generally.


Segher
