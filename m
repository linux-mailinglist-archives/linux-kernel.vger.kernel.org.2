Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA0423DB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhJFM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:26:04 -0400
Received: from mail-eopbgr140137.outbound.protection.outlook.com ([40.107.14.137]:11828
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231335AbhJFM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:26:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj8H9RZ7c48pHnzhXxcC43fIRa3nw3RankNzvLxV6v3G4DIgGdNTW2rQBJoh7gq5LXJLhoFviB5UHQzAsFKG6Pt4zTUjnVTtDQ4EpqTAsOP/hZ/OCpQxFP4nAR+T28F+F4c6SE5ldeueLUbmJIT1EGoD25NtnGon0DefmyHJvKJDZDhtL4rpbbRfyU5NDeGdTp7R0aVYTjfaD2D/jJ8sqHHUlMDzKPZ9h5tAS1wAygRRhhbm27aDuwWucQ75pUMxxVTrnteUzezxLeHmcyo+kR23HdalqcEfFH3AcSPyUCxQFllwNjJckh6mb1L/qSbkc13K6zbEx/6600xbcjfTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MshqCTrPZ3LCUnTdgO9Eq6Vj2O0kwE2jYWgt/HhlZIo=;
 b=NHrGypF+hZMdBb0FODYTQx9l4Mf40DgRXFvHTsSXtyXbon+vE6szQen2XEzIR3TKUmTC4PqmcZJwZWbsoImQhqsF1FYgnQfi9/S+jbvtwJ0equIislY3pPzBe/YT5TixKTFwNppJ1BtFb9cxBiSWZgXDtHusqg8YrLdUFx2wO77UNRoVZ82b8zv6mGj9ZqmzNSwchM+5WOaPw8ZehuR9GMMI9nmvz7Ey0ufW63lpXM5vhZukDv9cSSNIgqtlz38FwDhhqZALFMmXHUpLZxJlZM8rf9lAhXiLV97m5fboU0eckzoiIL2PPNLiROmMAi/BYqHGR3HD0AIcRtv7yAFEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MshqCTrPZ3LCUnTdgO9Eq6Vj2O0kwE2jYWgt/HhlZIo=;
 b=SSyn6Xwxn9dTJ6GbiHyDFwI//Zd65Exj0T40mXpj7IqcTfglHCKN/hyF4si8TZDP9C+56t9ghX7o3K5OWqn2NePQTe8lgb+KVBl5lz31uSekOtFuUELgw+IPxTPTcAaQK1+seP/cv4klm6EDfiai7c/6Fl0wSXCzQRTvs5M2We0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2613.eurprd02.prod.outlook.com (2603:10a6:4:1b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 12:24:09 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 12:24:08 +0000
Subject: Re: [PATCH 0/2] Add settle time support to mux-gpio
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        devicetree@vger.kernel.org
Cc:     kernel@axis.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20211004153640.20650-1-vincent.whitchurch@axis.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f056ed07-46d4-7f75-f6af-29f843c37d15@axentia.se>
Date:   Wed, 6 Oct 2021 14:24:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211004153640.20650-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::32)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 12:24:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7944511c-d192-4c34-8fca-08d988c43237
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2613:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2613948500D6F659A2100044BCB09@DB6PR0202MB2613.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +38EsHZifD5eyyyo7f+Etc7e46CGlw4I5eWSHseGoYkHBY3kwJhSMImuqgZuEgtoQEZAe5SKIQIm9v3iqVc3YDKjXFKZJUjl6gwHwFGkHajT5GP/TQU/rlOA4ninw+QzgwamTfKg2r4x3cUmF7n0w5P0WR4Cm884+8WPPjkOcLl/sLirUyIELDMb76dvyoMOQxOWBqyzLzIvXKQmz+W+Qwg6GVYz/rdxMFso4R3aa+kKMPT1FpnPpuJ4sKuxcS0LFRtgtXGXOvF3pZbcsKXTliInOz3YG4s4KGJlg9ioGVL/gPyd2ADGYMo4PzLP+QAyyHki4yGt0bo9dNUoVzdCvpD59Z922xI/yTlEP+57Jy3JGZuGUOySh8ipARI1AJiR6VECfbIN8wtgZ9QJapWIqDhLMbjKFJ+FZFZOYYY7hsFmQknY26PWfA20ibQXxHlQSJG2P0z8AZOO7aUpD15OLclGwiuEeR4Y4jHROsJw2cznsemHgSH6N51MIdB9OGW4o3+ZaTFdSdQb2TSueSRqZiSH9XXqAhO0oeZSgX5+7YlyVzGepz/xGBs/TCL/dN59CST3AAM63N1wjBdFFRoKxk3iBHsyOsbwaJtUUIC3O2zOCQNXal849ki10PAzf9ULzGR7ahbPlIUgG3kkNgX3kshbdfH/vaLRfCfr7j5dzIZQzV6oj20VJ+Xj1xHGdV0vrSOddhX4z1kNhjdAE2qqN+fvVehyFdkbK9r3NehXia4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(346002)(366004)(376002)(53546011)(31696002)(6486002)(186003)(508600001)(66556008)(26005)(2616005)(66946007)(956004)(4326008)(36756003)(8676002)(2906002)(66476007)(316002)(36916002)(8936002)(86362001)(31686004)(16576012)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhSTktRWE5SNkFFaE9uUWo3bkt3QWpnMEU2OFZlRjY3djFrOUZiQTBzU1Rj?=
 =?utf-8?B?U3Y3SktkakV3VkRQM3NjSUVEaFBtczd6ZysvTG9hU2l3ZmQwTndacmk2d3da?=
 =?utf-8?B?K2dkcytFMEpOR2l3cHBtbHZnTEVsQjdyc0lOT3BSMnYvQkJoV2dwckNjUTlD?=
 =?utf-8?B?QXhCd21pVXllQlBxTXp1NnBJbURSNVAzaGpNNlF1Y1lLSkFCc1RsUEVGa044?=
 =?utf-8?B?UmdhcDM2dk1zcFZHa2cvRnNiNExDTS9yZ3ltUTlpNlllWFdTT0tyaTBBY2N1?=
 =?utf-8?B?YjIzRjVxQk93OGIxdGxHOWJOc0VrdU1OdyttWkdlNXlkMTB2NG5lLzR4blIr?=
 =?utf-8?B?cWZENWxGOXMyUFV3dWlkZmtSQmNqVlZpUmRrOHI3YWlJbDZBMTBkQ0Q5TWs3?=
 =?utf-8?B?WlczSFZBU09LL2s1MVh2TXE0bXlCaHZZbmh5YkhHWkh6TU1ud01zK21XZDhi?=
 =?utf-8?B?cnUrUzJPWjNsUm4waUNSQ1VNakZ6NlRMV0FwSVBqVzVDZ28vUkhTZXFBYnV6?=
 =?utf-8?B?WVN1WmxFV2ZZSTdJVWFPVVdoNHpENzVyRDcrUEs4SFQybld6Zm5ZRVA4ZGNB?=
 =?utf-8?B?OWU2QkxhKzlUWEJUNi9sWWNBdW5haTFCeXdVK0J1NWFMajNJRDBWQWNLTzAw?=
 =?utf-8?B?Y2dUSXJMaExxL2tEaFFKVDZKQ2pya2dBNE1oWSsvcG02NTJ1ZW5uY0t5RC9N?=
 =?utf-8?B?aGFPTEYvVEZXbGJTa0dGWGRxbWFGOGxiZnhoNW5Fa3VsUmhkcHAzM09pYmhE?=
 =?utf-8?B?Wml1aVNxQzNydmpMbm5iRWFqVnp1NEh6djNwaTd1TktPUEg3M2N6TUxLSkZn?=
 =?utf-8?B?Mng5dFk3UTNCZXpYS2NEQkJLcmNMa1RuV1p4VlNpOEQyN1Vza0NJdGtGYWx2?=
 =?utf-8?B?NXdMR0dOanhyWTVlM3ZlK2xVQnllN2U2UHpMVTFjMXhhQlRQcXhjT004UTZX?=
 =?utf-8?B?aE9QRmRMdUpoVEJXdG9ReUxRQTNud3JsSHFKNFVZay9DZW9ONzB2OTJxcG0z?=
 =?utf-8?B?TnlKRlAraDRIczh4ODBRc25UTzVDanAvSDJlWFNVTG9WVm12Lzl3dkFWc1pw?=
 =?utf-8?B?YVpka1NCbzh0cWYrRlhoZ2doems1VE53YmE0TU5yT2cvN2M4TGlNV09Mb0Rj?=
 =?utf-8?B?WjlTc21vWFFTZVY4UDBoUHVtdWRkUDhDOFJpWUhtQVIxWVo2RWRkQVRWcGFP?=
 =?utf-8?B?Q09YT296VzlZS1NvT3h5SkR0aVM1cWU2Tnd4bXVqcFo4T09rc005VXhoTUwr?=
 =?utf-8?B?SWk0UFBhZHFsdE8vcjFWU21lblZESkJjVEM5SnFkU2dXNWY0MEliV3l5blk1?=
 =?utf-8?B?M3FoNEtGZmhYZFBIeHV1WXk0Y1F4WW0rajNyQ0N1S1EvdUNmS2dZbDcrR0I2?=
 =?utf-8?B?SWdpSGdtN1hFdUl1Mm4vbFpRSzJtUXZ0QmRGSTQvaWJHRDVydUVmNWIzNERL?=
 =?utf-8?B?S0o4M0xuLzBmNkRKTmxxTVkrclRwV3Z2YUJLQVd4a3E2ekg3UVpSa2VGVU15?=
 =?utf-8?B?S1ZPVmg2U0RRV2xJdE1WMm5hdG9SbnpDSTNwNE9DTjYvV2F0bmlTcm5KS3JS?=
 =?utf-8?B?YkxLdkpiNlJRRXRPNzhzK1kvQlZ6QzBnSzVnM2hUODMzTDhzV3A0YnZsMDhG?=
 =?utf-8?B?dFRTdFplVlh4bGVRVHJ2OWNZOUhWSE1iYWM2ZTJIeFZFcUxkR0xDVms4Rytw?=
 =?utf-8?B?ODdMWlZQL25CbFlWN2NmdDNpTHE4amROdHRhUk5RVWJ0cXlEZlR4QmVXVUNa?=
 =?utf-8?Q?KBeOmQnPMpVBFGtjA3pTTv071hNi4nSL3xBlYMy?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7944511c-d192-4c34-8fca-08d988c43237
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 12:24:08.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJGqNR0IVbtR3QClcLwSltKgwXSTiANPRag5mRb7JPrW8dilE8PY7zrem1yPdBmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2613
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2021-10-04 17:36, Vincent Whitchurch wrote:
> On one of our boards we use gpio-mux with iio-mux to read voltages using an
> ADC from a few different channels, and on this board the input voltage needs
> some time to stabilize after a switch of the mux.
> 
> This series add devicetree and driver support for this kind of hardware which
> requries a settle time after muxing.

It feels backwards to hide a universally useful thing like this fsleep in
drivers/mux/gpio.c. I think it belongs in drivers/iio/multiplexer/iio-mux.c
instead. Because the sleep is needed for the analog parts of the actual mux,
not the digital parts of the mux-controller.

However, currently the iio-mux does not know when the mux changes state (and
it can change state from "underneath" iio-mux by some other driver using the
same mux-control to drive some other mux).

But, fixing that so that the iio-mux knows if mux_control_select changes
the state (e.g. returning 1 instead of 0 on state changes) does not fix
this problem. Because the mux-control, again, can be used by some other
driver that changed its state right before the iio-mux selected it without
then needing a state change. And that could potentially happen quicker
than the prescribed fsleep.

So, fixing it needs some kind of new api that returns when the mux-control
changed its state last, e.g.
	ret = mux_control_select_stamp(mux, state, &stamp);
that does the same thing as mux_control_select, but also fills in a time
stamp for when the mux changed state.

Another similar option is to add an extra delay argument, e.g.
	ret = mux_control_select_delay(mux, stamp, delay_us);
that instead makes the call not return before the delay has passed since
the last state change, regardless who changed state. The mux-control would
need to keep track of when the last state changes happened of course, just
as in the above _select_stamp variant.

I think I like the last _select_delay variant best.

Cheers,
Peter
