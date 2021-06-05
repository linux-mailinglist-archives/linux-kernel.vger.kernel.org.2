Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FC039CA2F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 19:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFERX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 13:23:27 -0400
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:53594 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229964AbhFERX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 13:23:27 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4E0671800BCE9;
        Sat,  5 Jun 2021 17:21:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 95C4020D751;
        Sat,  5 Jun 2021 17:21:37 +0000 (UTC)
Message-ID: <eac3b988f4993a77f8eea3550a6dd5980b25e92f.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix check for embedded filename
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sat, 05 Jun 2021 10:21:36 -0700
In-Reply-To: <20210605161219.26421-1-dwaipayanray1@gmail.com>
References: <20210605161219.26421-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 95C4020D751
X-Spam-Status: No, score=-0.25
X-Stat-Signature: 9mhpmgziyw115c9xfm4orb1sj7uxsgda
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+dYvqRUUGcbVZeyiyR6DtKki6+ovX/7UI=
X-HE-Tag: 1622913697-765406
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-06-05 at 21:42 +0530, Dwaipayan Ray wrote:
> When checkpatch is run on file contents piped through stdin,
> it may generate false EMBEDDED_FILENAME warnings if the
> --file flag is used.

I think this is a "don't do that" scenario and this change
is not necessary.



