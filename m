Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE993CC73E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 04:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhGRCrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 22:47:49 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:58582 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230102AbhGRCrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 22:47:48 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id EF5051802DEC3;
        Sun, 18 Jul 2021 02:44:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 2A9C2255100;
        Sun, 18 Jul 2021 02:44:49 +0000 (UTC)
Message-ID: <a5464cd463a3e6a773c8dd4616b535df3e136154.camel@perches.com>
Subject: Re: [PATCH] checkpatch: remove obsolete check for __dev* section
 markers
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Sat, 17 Jul 2021 19:44:47 -0700
In-Reply-To: <CABJPP5Dqy4XAob_6D5TSX+hURs5JX+ufz2Tg2o=bR7kbMoGzMA@mail.gmail.com>
References: <20210716182126.4392-1-dwaipayanray1@gmail.com>
         <CAKXUXMyvOh0GvpEf4uX5iFJYOJLo43tmO16Uf34j4i6XD0vBcg@mail.gmail.com>
         <CABJPP5Dqy4XAob_6D5TSX+hURs5JX+ufz2Tg2o=bR7kbMoGzMA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2A9C2255100
X-Spam-Status: No, score=1.60
X-Stat-Signature: uzg465ojm8im4wfnct1xurt76wq4or7m
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18e+RIpQgtpUepwhLON4ozzrDY8DNPBkfY=
X-HE-Tag: 1626576289-302524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-17 at 22:27 +0530, Dwaipayan Ray wrote:
> This particular check was added by Joe in 2013 when the process for
> __dev* marker removal was in progress. If he has no objections to it,
> I can send in an updated patch.

I have no objections.
Removal of the unnecessary or obsolete is good.


