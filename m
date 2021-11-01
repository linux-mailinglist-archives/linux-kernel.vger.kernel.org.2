Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874B04420D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhKATaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:30:04 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:43238 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231820AbhKATaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:30:01 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B4611100C1CFB;
        Mon,  1 Nov 2021 19:27:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 97C85315D79;
        Mon,  1 Nov 2021 19:27:25 +0000 (UTC)
Message-ID: <b1d42de162c02f6027ab3ddd8c2d3fb0fd4cd220.camel@perches.com>
Subject: Re: [PATCH] speakup: Fix typo in documentation "boo" -> "boot"
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin Ian King <colin.i.king@googlemail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Nov 2021 12:27:24 -0700
In-Reply-To: <87k0hr6bfx.fsf@meer.lwn.net>
References: <20211028182319.613315-1-colin.i.king@gmail.com>
         <20211028182451.baizgvczghh37zfl@begin> <87k0hr6bfx.fsf@meer.lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.07
X-Stat-Signature: u1ep7x4x71g8idx8z5ydgzohu83zruha
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 97C85315D79
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19eyUiIxaTyRbOTrnxTUjk51d558FEbxZ4=
X-HE-Tag: 1635794845-741129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 11:19 -0600, Jonathan Corbet wrote:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> > Colin Ian King, le jeu. 28 oct. 2021 19:23:19 +0100, a ecrit:
> > > There is a typo in the speakup documentation. Fix it.
> But ... we just got a kernel named "trick or treat" and now you want to
> delete "boo time"? :)

Maybe a few more for dia de los muertos.'

Documentation/devicetree/bindings/crypto/fsl-sec4.txt:      Value type: <boo>
Documentation/devicetree/bindings/example-schema.yaml:      - enum: [baz, boo]
Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt:    Value type: <boo>
Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt:    Value type: <boo>


