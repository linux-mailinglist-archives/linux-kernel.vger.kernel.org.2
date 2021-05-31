Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC243396646
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEaRDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:03:05 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:51470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231845AbhEaPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:51:09 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6242E1822186F;
        Mon, 31 May 2021 15:49:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 49EC5315D79;
        Mon, 31 May 2021 15:49:23 +0000 (UTC)
Message-ID: <4f439c33c8f09da9f0fe44e8eebd98286c3e1e3e.camel@perches.com>
Subject: Re: [PATCH 03/10] i2c: xiic: Fix coding style issues
From:   Joe Perches <joe@perches.com>
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        linux-i2c@vger.kernel.org, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, marex@denx.de
Date:   Mon, 31 May 2021 08:49:22 -0700
In-Reply-To: <20210531131948.19477-4-raviteja.narayanam@xilinx.com>
References: <20210531131948.19477-1-raviteja.narayanam@xilinx.com>
         <20210531131948.19477-4-raviteja.narayanam@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 49EC5315D79
X-Stat-Signature: w94xhhawad55pwuiot6k8qyufdna9ikt
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX195e7L0MdWo55+YrZXpA8kMRysCT477u90=
X-HE-Tag: 1622476163-449368
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-31 at 07:19 -0600, Raviteja Narayanam wrote:
> From: Michal Simek <michal.simek@xilinx.com>
> 
> Most of these stuff are reported by checkpatch.

trivia:

> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
[]
> @@ -519,8 +522,8 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
>  
> 
>  	/* Service requesting interrupt */
>  	if ((pend & XIIC_INTR_ARB_LOST_MASK) ||
> -		((pend & XIIC_INTR_TX_ERROR_MASK) &&
> -		!(pend & XIIC_INTR_RX_FULL_MASK))) {
> +	    ((pend & XIIC_INTR_TX_ERROR_MASK) &&
> +	    !(pend & XIIC_INTR_RX_FULL_MASK))) {

This last line would more commonly be indented one more space to
align to the appropriate open parenthesis depth.

tab then 4 spaces for
	    ((pend & XIIC_INTR_TX_ERROR_MASK) &&
tab then 5 spaces for
	     !(pend & XIIC_INTR_RX_FULL_MASK))) {



