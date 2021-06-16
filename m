Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE23A9A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhFPMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:36:11 -0400
Received: from mail-db8eur05on2096.outbound.protection.outlook.com ([40.107.20.96]:18016
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230197AbhFPMgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wumq69Xk6ZziTgGpMLYyYffdjfXxnbtU2Se+7svYkGOQ1+K704YjJJ75pDqJdV5LhpG/W5oK0zeqpv5X6Cur+9PhvIS5erjO2vNLsUjqU2gBa2EyD8zrCjH0T8xGxxqFHTU9iFOmDQSrsdFSVOxnaHV6f+MqHi0BwRc0gGFMbpai99MRnGlYK21sEOenq19PNBLoq2T/Dvae7KvVLvSGqeG/0cj4QxBWEVaVxjNCOqsCW1ch4hkS8tEXX2Vo7y+ZzFz/WHLEBCR3tLjY6bmEekwbWxdh4/OWL69t+Bjr1h34l8ESSXcd5/D7MCPbzok89wyGORblO6U0B/Lu2p8avA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsHTBfftGUIyqVYEptwImapxL7qhsdKw51zdWJW3Zqg=;
 b=aO58hHtf7lRL01/34XylAPx8CTfhbtEYXUQoZI44AedoLfKiMuGjmXrOvL1dKYgB8VxIceJQKtvtwYp5tulbmQRuzipxMS9HVQCYU/vgtDErOzQGUqdxt6NpnzCvPrVDQid+g1eHk3e5uhPM9Li17/zal09r/NSjj+8O3Of8yZLsi265O8sQbGKDHK7Wtp4l7El11vaToqNKxO+fuI556BC73tKxHvwM9yVNxmnj6yBCrmfLbnQGuAQ6srl9HXbTg7SYu7krvtpKEmayyGsWUF2ET3ofAOGR56EeR62AuUDcaazxMlyUxoTjxUAtJBs2HWnm4uhJXLmmaCRYEsScxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsHTBfftGUIyqVYEptwImapxL7qhsdKw51zdWJW3Zqg=;
 b=mXemLe6JGGP6hH9Qrp2LbUwMVxg/nwA4YmykIYzZHDUZLNn+I57eGuAQP3/MO5XxId3BHUCtq4jutaGmjREY0oj4TlG7YWg/bP9qrHx2WGsc8/XnYLLIlBZkbvUfKhT+epEIdAPhTlB4VETRIW/iFAn19omCdcwgVPB8Vs5bFxo=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0154.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:c9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 12:34:00 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::e58c:4b87:f666:e53a]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::e58c:4b87:f666:e53a%6]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 12:33:59 +0000
Date:   Wed, 16 Jun 2021 15:33:56 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
Message-ID: <20210616123356.GA9951@plvision.eu>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.20.186.93]
X-ClientProxiedBy: AM5PR0701CA0018.eurprd07.prod.outlook.com
 (2603:10a6:203:51::28) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM5PR0701CA0018.eurprd07.prod.outlook.com (2603:10a6:203:51::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Wed, 16 Jun 2021 12:33:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b841befa-5e84-4f2a-ac29-08d930c303fe
X-MS-TrafficTypeDiagnostic: HE1P190MB0154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB01549B76490A798C782FF753950F9@HE1P190MB0154.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYoX++HUzCYdCbtTeTInvDU3j9XzAS/4QACjMfs0WKKzKs10sG7MqcBLMq4bNpJZBTaOSVXaZ9uiyeWs8w/Xfq7D7ADA6A78NngUTcsXFEs38GeIGqtz/g0ApCarmjZF90gs9hJwEW2LbFG1ExZGlW6hXiz9enbB6PrKhW8WIW9KiVhWI+ku5rEO6tp12o4I0ie5OQIRlNnQnb0z4bx6hCnDBWTInH/pOwPgiYxK6t/ohBiDz8LfALS7AiPOXoNi5/+m0YtZzve6RQo3df1fSdIunTkqRsXcKKmFiyW0HODSbdaMn4kB0rP6ZD0lEYxBYCBAdt0Um5BISIM1BckwsfjZxok6MtuwYbL99fjJor3Iyxw6ohXXpvsFyW4GrrfPN/5hACzw0eKEQAcQ4nmGyaT/asB5SLwSPlqParfTzZxnuE+JYoSKmOE1xzHwmD4XHdqqfDrcWFyWy7QnZGa5s2oJdCRmYSXb0sW35b/ijrrKdfh6BKJD228zrY3UKIF0oGtulwicpeUeqrDz5VzCu4WaEtNx1YmAhVwJ/Jo2esWaIFW5rYLliAQ1iU8p2tqLR3Q2v+ERioS6wd6w/DLvuRPXPviixT4oGTrcKtX+gptcbgjiLaG5MBw6SOv0TalPJ9ZPv6ZfXAamvqiVmNprXAfkfcEfJMFAey93zRwemaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(8936002)(38350700002)(44832011)(7696005)(5660300002)(508600001)(53546011)(6916009)(8676002)(38100700002)(66946007)(956004)(2616005)(4326008)(66476007)(66556008)(86362001)(83380400001)(33656002)(1076003)(52116002)(2906002)(8886007)(16526019)(186003)(54906003)(55016002)(36756003)(26005)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2mNbZ13MjPRQ+kCh6gt++nt2Z2rjMrIa9XcZYokS0AIAlNARcTtLNPajxyRV?=
 =?us-ascii?Q?zNGa8QDLHGczEBlSLGjeFWhx7BGIo5Wpc/Bs9XTReYZcvWhY9wT/INraLn7d?=
 =?us-ascii?Q?q2DRry8PQhz2ncel6hmj4XUzi4n/UTE4j3zQ8UzrKVgPOGy3e4/o8kWTRQ62?=
 =?us-ascii?Q?RNI/NhExaQvLqPWvMBDupC5eBVVQqaEZRhTiRUvXJCaF06HQuWlyDHR1W7Qh?=
 =?us-ascii?Q?vB6Y5GdbxQfR2Xe84rhL4Nure2XDNE9aAl6JktYU6HRiGNgn0RTJppccC8fp?=
 =?us-ascii?Q?G1F6Ib2nnCWBHuQL+hEWWVDM1aQEV1kVW5qBWVtBzuoaQlTrHz+M2t2jUEoW?=
 =?us-ascii?Q?NIBlYHeGdtDhClFK588f7X0PdcMePVBZqg/Xa+HuFliuHHxSDQmTFanEASkl?=
 =?us-ascii?Q?eZM7Pyv2FjVJzqww4i/1SSEcVBiepfIXX6LeUYimY6zsAUi0GjWVZZ/FcuWb?=
 =?us-ascii?Q?X+mHmr1x44N0f6hTU7xplVfkaxe9kclMbdWgZqDyyVWwkMZsrv2v584Lm3ch?=
 =?us-ascii?Q?CQRxjkaBZQ8KB4b6M0aZnt5mhOF9k2hL68Dc8cI90GK72+mH9J3Wf03YJlYM?=
 =?us-ascii?Q?/2X1/aDbBW86bPzuohu/Dku/Obc7bElLa2LVzMEACsAQ26odaBlPZseQYnjK?=
 =?us-ascii?Q?41Q9G0Ei5OLsYroUYpgUkSfgE/71+Ga1cslYm1GZ/lbFzPWMHzmiV6y/F+Qk?=
 =?us-ascii?Q?lRJJ9l7D3qw/sv75/ttOiVKQjDV3mRMF4bMAd3zQcjLRgUnmN8mSqA/7btST?=
 =?us-ascii?Q?+Ejz/ofJL6EC7FNvNJqnOpoXfqIxKsxpP8NxdzsmYMQMXWqO72A9VlID7vKA?=
 =?us-ascii?Q?hCUWWHKTEm01CcgqwcTdn86bJzcH2vgGLLOKooH77UTG2aDRR3gfwjeN25HK?=
 =?us-ascii?Q?Hrzes1EQhlOQ5/BGy8DHHbh/c40Jndt2oSOEnFOArgqwIZYuatMsK57TtkU5?=
 =?us-ascii?Q?lPjNl6whzlDaEyawZbEqTIf2a+AqAXNzPDzugUiUBdSOVWSKF4dpzis5M5tS?=
 =?us-ascii?Q?+3iZYE8Ww07MkPO8W8NmTcNIad/lBdYfDt4aOmKjTjCRTSGymM2Zm+15fwZG?=
 =?us-ascii?Q?Xhd2G7WMQYb7GWDKBFZY+h4k59Xalf5GQkU/cdf13sOLPuGBA7tprimQ5pIa?=
 =?us-ascii?Q?Mi2R/Sw/LEMAcNHziHUapV0uf706hZjN7Ch8BMwKoE0LDK+s5dyX6BTfSoI4?=
 =?us-ascii?Q?HPLDwEjJMHqJ+KlqIG248gWYdtajmFFCX5n11cWXhjMxrfgP+ZllAbLTLois?=
 =?us-ascii?Q?qiZ995Od0ssV+/o+T7LBPdMSvreZAxvOmZPDPKcmdTN2U01ClBq/TXRyJq2x?=
 =?us-ascii?Q?i8uYPjF9J7CmDAaDARmhPEiz?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b841befa-5e84-4f2a-ac29-08d930c303fe
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 12:33:59.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjX/4VI0MZbfhGBud+Pr/B5v87ByAMVlXNPaZ0Vnualu0J0CcBvooYm620OpYYHJBKFwplbAz6C2GwqQgMV0ieu9OefP/TCz7ITqu4a0Nlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0154
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, Jun 14, 2021 at 11:44:59AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 08/06/2021 20:03, Vadym Kochan wrote:
> > Current implementation does not allow to register cells for already
> > registered nvmem device and requires that this should be done before. But
> > there might a driver which needs to parse the nvmem device and after
> > register a cells table.
> > 
> > Introduce nvmem_parser API which allows to register cells parser which
> > is called during nvmem device registration. During this stage the parser
> > can read the nvmem device and register the cells table.
> > 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> > v2:
> >      1) Added nvmem_parser_data so parser implementation
> >         should fill it with cells table and lookups which
> >         will be registered by core.c after cells_parse was
> >         succeed.
> > 
> >      2) Removed cells_remove callback from nvmem_parser_config which
> >         is not needed because cells table & lookups are
> >         registered/unregistered automatically by core.
> > 
> >      3) Use new device property to read cells parser name during nvmem
> >         registration. Removed of_node usage.
> > 
> >      4) parser's module refcount is incremented/decremented on each parser
> >         bind/unbind to nvmem device.
> > 
> >   drivers/nvmem/core.c           | 178 +++++++++++++++++++++++++++++++++
> >   include/linux/nvmem-provider.h |  31 ++++++
> >   2 files changed, 209 insertions(+)
> > 
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index bca671ff4e54..648373ced6d4 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -39,6 +39,7 @@ struct nvmem_device {
> >   	nvmem_reg_read_t	reg_read;
> >   	nvmem_reg_write_t	reg_write;
> >   	struct gpio_desc	*wp_gpio;
> > +	struct nvmem_parser_data *parser_data;
> 
> This should be renamed to nvmem_cell_info_parser or something on those lines
> to avoid any misunderstanding on what exactly this parser is about.
> 
> May be can totally avoid this by using parser name only during register.
> 

I added this to keep parsed cells particulary for this nvmem in case
same parser is used for several nvmem's and mostly because of using also
cell lookup info. I will try to also answer your below question why do I need
lookups ?

I use of_get_mac_address() func to fetch mac-address from nvmem cell.
Eventually this func calls of_get_mac_addr_nvmem() which (as I understand it
correctly) can find cells via DT by parsing "nvmem-cell-names" or via cell lookup
info of platform_device. I use the 2nd option with the following sample
solution:

	## DT ##
	eeprom_at24: at24@56 {
		compatible = "atmel,24c32";
		nvmem-cell-parser-name = "onie-tlv-cells";
		reg = <0x56>;
	};

	onie_tlv_parser: onie-tlv-cells {
		compatible = "nvmem-cell-parser";
		status = "okay";

---> add ability here to map cell con_id to cell_name ?

	};

	some_dev_node {
		compatible = "xxx";
		base-mac-provider = <&onie_tlv_parser>;
		status = "okay";
	};
	########

	== CODE ==
	base_mac_np = of_parse_phandle(np, "base-mac-provider", 0);
	ret = of_get_mac_address(base_mac_np, base_mac);
	==========


And it works with this implementation because onie-tlv-cells is
registered as platform_device which name is the same as parser's name.
So the really tricky part for me is to make this cells lookup work.

Of course would be great if you can point a way/idea to get rid the need of
lookups.

> >   	void *priv;
> >   };
> > @@ -57,6 +58,13 @@ struct nvmem_cell {
> >   	struct list_head	node;
> >   };
> > +struct nvmem_parser {
> > +	struct list_head	head;
> > +	nvmem_parse_t		cells_parse;
> > +	const char		*name;
> > +	struct module		*owner;
> > +};
> > +
> >   static DEFINE_MUTEX(nvmem_mutex);
> >   static DEFINE_IDA(nvmem_ida);
> > @@ -66,6 +74,9 @@ static LIST_HEAD(nvmem_cell_tables);
> >   static DEFINE_MUTEX(nvmem_lookup_mutex);
> >   static LIST_HEAD(nvmem_lookup_list);
> > +static DEFINE_MUTEX(nvmem_parser_mutex);
> > +static LIST_HEAD(nvmem_parser_list);
> > +
> >   static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
> >   static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
> > @@ -418,6 +429,118 @@ static struct bus_type nvmem_bus_type = {
> >   	.name		= "nvmem",
> >   };
> > +static struct nvmem_parser *__nvmem_parser_get(const char *name)
> > +{
> > +	struct nvmem_parser *tmp, *parser = NULL;
> > +
> > +	list_for_each_entry(tmp, &nvmem_parser_list, head) {
> > +		if (strcmp(name, tmp->name) == 0) {
> > +			parser = tmp;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (!parser)
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> > +	if (!try_module_get(parser->owner)) {
> > +		pr_err("could not increase module refcount for parser %s\n",
> > +		       parser->name);
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	}
> > +
> > +	return parser;
> > +}
> > +
> > +static void nvmem_parser_put(const struct nvmem_parser *parser)
> > +{
> > +	module_put(parser->owner);
> > +}
> > +
> > +static int nvmem_parser_bind(struct nvmem_device *nvmem, const char *name)
> > +{
> Do we really need parser bind/unbind mechanisms for what we are trying to do
> here.
> 
> It's just simply parsing cell info during nvmem register, do we really care
> if parser is there or not after that?
> 
> code can be probably made much simpler by just doing this in nvmem_register
> 
> parser_get()
> parse_get_cell_info()
> parser_put()
> 
> AFAIU, that is all we need.
> 

because of need of lookup info (just in case if it is needed) the unbind
stage should free the lookups during the nvmem cells removal, but cells table
can be freed even during nvmem_register after cells were added.

> > +	struct nvmem_parser_data *data;
> > +	struct nvmem_parser *parser;
> > +	int err;
> > +
> > +	mutex_lock(&nvmem_parser_mutex);
> > +
> > +	parser = __nvmem_parser_get(name);
> > +	err = PTR_ERR_OR_ZERO(parser);
> > +	if (!err) { > +		data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +		if (data) {
> > +			data->parser = parser;
> > +			nvmem->parser_data = data;
> > +		} else {
> > +			nvmem_parser_put(parser);
> > +			err = -ENOMEM;
> > +		}
> > +	}
> > +
> > +	mutex_unlock(&nvmem_parser_mutex);
> > +
> > +	return err;
> > +}
> > +
> > +static void nvmem_parser_unbind(const struct nvmem_device *nvmem)
> > +{
> > +	struct nvmem_parser_data *data = nvmem->parser_data;
> > +
> > +	if (data->table.cells) {
> > +		nvmem_del_cell_table(&data->table);
> > +		kfree(data->table.cells);
> who has allocated memory for this, its confusing for this to be freed in
> core.

Well, looks like I need to call parser->cells_clear() so the parser driver will clear
things by itself.

> > +	}
> > +	if (data->lookup) { > +		nvmem_del_cell_lookups(data->lookup, data->nlookups);
> > +		kfree(data->lookup);
> > +	}
> > +
> > +	nvmem_parser_put(data->parser);
> > +}
> > +
> > +static void nvmem_parser_data_register(struct nvmem_device *nvmem,
> > +				       struct nvmem_parser_data *data)
> > +{
> > +	if (data->table.cells) {
> > +		if (!data->table.nvmem_name)
> > +			data->table.nvmem_name = nvmem_dev_name(nvmem);
> > +
> > +		nvmem_add_cell_table(&data->table);
> > +	}
> > +
> > +	if (data->lookup) {
> Why do we need lookups?
> the cells are already associated with provider. lookups are normally used
> for associating devices with nvmemcell more for old non-dt machine code.
> 
> you can remove this.

I hope I replied this in 1st reply.

> > +		struct nvmem_cell_lookup *lookup = &data->lookup[0];
> > +		int i = 0;
> > +
> > +		for (i = 0; i < data->nlookups; i++, lookup++) {
> > +			if (!lookup->nvmem_name)
> > +				lookup->nvmem_name = nvmem_dev_name(nvmem);
> > +
> > +			if (!lookup->dev_id)
> > +				lookup->dev_id = data->parser->name;
> > +		}
> > +
> > +		nvmem_add_cell_lookups(data->lookup, data->nlookups);
> > +	}
> > +}
> > +
> 
> --srini
