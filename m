Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED938E097
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhEXFFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:05:51 -0400
Received: from fallback16.mail.ru ([94.100.177.128]:48670 "EHLO
        fallback16.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEXFFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=A6mQ6XXTAtiDXUBAWT7HV2+69EFPzQ3wZCDTdVg/Boc=;
        b=Ja8/iVJOyhhxVziEMfm6symjOXYpMjbR7TaYi+KNdqJ81VyJf5S6VqX49tTSv8tnB3UFQd4cWwmbCmVWme0/6UCx7EZ9K812Hbc/B8Pb+msEIe5Vb1NUMRl6KYCiaf+meDMaHBNs8lE3xDEWLm5f8uq8CEWSZ30zNmaZOcx8xvE=;
Received: from [10.161.64.57] (port=35608 helo=smtp49.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1ll2Yp-0004kX-Mq; Mon, 24 May 2021 07:51:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail3;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=A6mQ6XXTAtiDXUBAWT7HV2+69EFPzQ3wZCDTdVg/Boc=;
        b=ibzshwWZrEcQvU28BA/96SOwr4l5uf3wgLYIBUInBIZN24qGWWXKexsrzKc7bDkcEDtRnWNx8CjvTcVJm47kUjQIR7YiRusDnUt2v+I07bEHEbCqbw2PBoUXoO9STg1CstKjNhutOEyInkoyEfrHxFjWTOUhbl/PcQH1qWpneUo=;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1ll2Yf-0006Mi-44; Mon, 24 May 2021 07:51:17 +0300
Subject: Re: [PATCH 1/1] regmap-irq: Introduce inverted status registers
 support
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
References: <20210518094441.142547-1-fido_max@inbox.ru>
 <20210518120640.GB4358@sirena.org.uk>
From:   Maxim Kochetkov <fido_max@inbox.ru>
Message-ID: <c4fa6dbe-0e5c-3d8a-7c35-b34b7c18a244@inbox.ru>
Date:   Mon, 24 May 2021 07:53:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518120640.GB4358@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD91B019B01C53E51AFBEA66046F15EAF23C5E2F255C2D74AA700894C459B0CD1B93E6C79F09ECDD8174EA5F3BDC81F06853CD11F706BF6B6703B9FC492F4C8D7B4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C6068CE86C2B75F5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374D0D183F14C070BA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86FF8FE73FFD24581CD035F8EF94C65A4117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCAA867293B0326636D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BAA867293B0326636D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB1593CA6EC85F86D49AF716F719AB83ED8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE39E541A154B51D14B2D242C3BD2E3F4C6C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006377870F476E0DB9443EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-B7AD71C0: AC4F5C86D027EB782CDD5689AFBDA7A2368A440D3B0F6089093C9A16E5BC824A2A04A2ABAA09D25379311020FFC8D4ADB48D0DF8BC27391B496A29BAB8517C7F
X-C1DE0DAB: 0D63561A33F958A5DFC64086A20DC86DA77BF6358A29E74FB65DBAA05816C37DD59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA754263BA4E959D734C410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34D041FB2E16F174C4BB6820106AE9735D8BE144FFE9D6DCF06601664AC8D5697909486C6E5B133CCF1D7E09C32AA3244C888FA3FE6A00E80140AA5774266360567101BF96129E4011927AC6DF5659F194
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj+gjVyQcIK6I4xoQAk15MYA==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB249AD67B68AD1711E0AB3D1DA48BC4372E56D7F21BDCCCDD9FEE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4935A4DD83856F5F211EB3CDE1FDD2419BAFE2BE684A96E1F049FFFDB7839CE9E8461634FFA5C5E3C03D7EFDDE6D1ADC6C7FF69E2E5D7F4BA91C72E081E848CE0
X-C1DE0DAB: 0D63561A33F958A5F32CD9214611EEA4F39DD1F950ED2800FE01BEBA8F28A09CD59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdNO8XxRrSv8Ln1uNZIRpmhA==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.05.2021 15:06, Mark Brown wrote:
> On Tue, May 18, 2021 at 12:44:41PM +0300, Maxim Kochetkov wrote:
> 
>> +	if (chip->status_invert)
>> +		for (i = 0; i < data->chip->num_regs; i++)
>> +			data->status_buf[i] = ~data->status_buf[i];
>> +
> 
> This is the only active change so this only affects readback meaning
> that if both read and write are inverted this won't do what's expected,
> breaking acks.

I mean 'status_invert' as just status register has inverted bits. So to 
keep all other logic we just need to invert status register after read. 
It will not break acks because we can use ack_invert option to invert 
status back if needed. Anyway it will not affect existing devices just 
new ones with inverted status.

> I'm guessing your device either mixes things or is clear on read?

Yes my device is clear on read. It don`t use ack registers. It has only 
mask and status.


I missed read status register at regmap_add_irq_chip_fwnode(). I will 
send v2.

