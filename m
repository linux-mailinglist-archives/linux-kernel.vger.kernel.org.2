Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C4453C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhKPXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:17:37 -0500
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:60176 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230018AbhKPXRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:17:37 -0500
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F19C9837F253;
        Tue, 16 Nov 2021 23:14:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 0E456507;
        Tue, 16 Nov 2021 23:14:37 +0000 (UTC)
Message-ID: <a0bd71ce82c7c7b9cb72972b091f9f1054b6595c.camel@perches.com>
Subject: Re: [PATCH 2/2] get_maintainer: ignore "my" e-mail address
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 15:14:37 -0800
In-Reply-To: <20211116213403.820336-2-l.stelmach@samsung.com>
References: <20211116213403.820336-1-l.stelmach@samsung.com>
         <CGME20211116213417eucas1p133783708f01c8cf82bd341a4cf95a833@eucas1p1.samsung.com>
         <20211116213403.820336-2-l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E456507
X-Spam-Status: No, score=-0.15
X-Stat-Signature: duize6rc84rrsi4naataoaqmgwyifhz7
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+w0TX87MzmJniQXwTqTw0QJDnGJgF6BU0=
X-HE-Tag: 1637104477-253308
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-16 at 22:34 +0100, Łukasz Stelmach wrote:
> Ignore one's own e-mail address given as a parameter to --ignore-me
> or in the EMAIL environment variable.

Why is this useful?

git send-email already supports this.

       --suppress-cc=<category>
           Specify an additional category of recipients to suppress the auto-cc of:

           •   author will avoid including the patch author

           •   self will avoid including the sender

      --[no-]suppress-from
           If this is set, do not add the From: address to the cc: list. Default is the value of sendemail.suppressFrom configuration value; if that
           is unspecified, default to --no-suppress-from.


