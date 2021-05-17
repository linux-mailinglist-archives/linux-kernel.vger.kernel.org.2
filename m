Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA0383B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbhEQRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:23:05 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44655 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhEQRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:23:04 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 279C422205;
        Mon, 17 May 2021 19:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621272104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n0XeYHGKPn3tAk4NE5qtwy+82XOwHicwJhKVYd+Quu0=;
        b=NLt8ILfsYe7YGec6chkTMlUXi8czCzDDngpe0MJc9oiXEHZdKmD7nSj1TOeSwAe4cs56yF
        CfVr8FiXxt5qeluBrTq58lurxX/b6qcaH1XNsvAkETX6Rxfvp+Pwt8SoKquz5PG1aEjwzX
        Ips3+93bYN2qwlryvMcasvdoWSePluE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 May 2021 19:21:40 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: mtd: add YAML schema for the generic
 MTD bindings
In-Reply-To: <CAL_JsqK3Wym+ERaQ0np-v8HM39TyNUTAwbhKHPasOPx5xnMNsQ@mail.gmail.com>
References: <20210424110608.15748-3-michael@walle.cc>
 <20210510104411.11267-1-miquel.raynal@bootlin.com>
 <CAL_JsqK3Wym+ERaQ0np-v8HM39TyNUTAwbhKHPasOPx5xnMNsQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9c95f93c218028898c01970bfd9f3e0a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-17 17:12, schrieb Rob Herring:
> On Mon, May 10, 2021 at 5:44 AM Miquel Raynal 
> <miquel.raynal@bootlin.com> wrote:
>> 
>> On Sat, 2021-04-24 at 11:06:05 UTC, Michael Walle wrote:
>> > Convert MTD's common.txt to mtd.yaml.
>> >
>> > Signed-off-by: Michael Walle <michael@walle.cc>
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>> 
>> Applied to 
>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
>> mtd/next, thanks.
> 
> This is causing a warning in linux-next:
> 
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/spi/spi-mux.example.dt.yaml:
> spi-flash@0: $nodename:0: 'spi-flash@0' does not match '^flash(@.*)?$'
>  From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

For reference, the patch which fixes this:
https://lore.kernel.org/linux-devicetree/20210517153946.9502-1-michael@walle.cc/

-michael
