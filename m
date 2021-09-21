Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554AE412EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhIUGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:44:57 -0400
Received: from mail-eopbgr50122.outbound.protection.outlook.com ([40.107.5.122]:41861
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229755AbhIUGo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:44:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWF4CWIVtn0jH0wG7gO2DZVH0huqahQIluJhemmFvj/QRMrQiGKJXJAfkWTOhd2elqLfwom00XBseB7KqssjR7A331EQ94Tc56BNdWzkr/CYC2kSBjoQe/QM6kw1+WrBdy1M9KnRM5WX5a+/UZme2WYSO9sTXG8FMsZFub3OAP5spp157FCoBNTZcl8Uk3ayzoq78XuyWHpkTRtqRdLPAZlUSFh7oaJrPKc5esv/ApOKdSFsB400fYUAJgUejbuONXHRx3ccqMM9GXuDxdA8U6Z27/kJqckzd4J8qP8xXwXwrulAEeH8EmbkqwzJ0KY9prmXpXxPjn4hcloq5qge8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sSHBKr/7xrkJ2pKmbeueJqZ1G/3qS5bOeohiMDSA5HM=;
 b=Wt81TVbwwWUKv7J5prCG+LuqZJA03DhS/sTlgkIZOlWER2CwMMS3y3Pz4wKYhHY+Y12mSLNgJmbLaV8TWA4jIzzFK7V32uy5bNmCOKG91hD1/0GA+fJWqhmyj8TrLSOCOD0lGQsR0kMetoz4SJ7/7JB9t1KZIi6W8fPH/9Q7GClHS/SXdhjJlyQYmX9iteA7b3U23hsT7bG9ZyTuMHbU/NLilxSS+J+ldFcsFX4hKnLWAHwH1dWuVF2UheD8OxAlxG90Y4+AFG9rdyQsGGCq4Pry2LF/6uyeuuEUbrdqGbWmQaoFXdQXMmr4q4zZuNTxpsmXIvmmovqTFAY89thGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSHBKr/7xrkJ2pKmbeueJqZ1G/3qS5bOeohiMDSA5HM=;
 b=RxLczmmYIReU9SODyWS7+6l4sTvT1eCDYRrTjcLPW6JPJSAXxs9RRu40KEyvxAyNOwcL3Qh5hQPhxg/ytP8rZzW7gYa2OPFxm11If5J057nRZ+maPO+xt4Bqoq3RQEbx9a5WPPxIU6NG0zOYh7OXb+jmhZcusHU5FhPbAOBAgOc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 06:43:26 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5%7]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 06:43:26 +0000
Message-ID: <53428074-2e0d-52c0-5638-f286caf36949@kontron.de>
Date:   Tue, 21 Sep 2021 08:43:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Heiko Thiery <heiko.thiery@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
 <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
 <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com>
 <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com>
 <CAOMZO5DEg81E23QBpsv44BxytEhNNoXy-r5BbnubUJTERzWYLQ@mail.gmail.com>
 <CAEyMn7Yvc_tck=Hd8GE1a7uO8nRsrkdJ7b_jL6EY0-U6b=TjoQ@mail.gmail.com>
 <039c9214-423f-0f62-f6d2-6f2c969512fa@kontron.de>
 <CAOMZO5A4x_v8wtGyDjLdMg_hS1=UZH3LV-e+Dyz=spmSaLyAaw@mail.gmail.com>
 <5d5fd917-a330-21b9-f8c1-25792a0f11e9@kontron.de>
In-Reply-To: <5d5fd917-a330-21b9-f8c1-25792a0f11e9@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0055.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::30) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
Received: from [192.168.10.40] (89.244.183.176) by PR3P191CA0055.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 06:43:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c5f6e4c-c988-493a-22e8-08d97ccb1d54
X-MS-TrafficTypeDiagnostic: AM9PR10MB4087:
X-Microsoft-Antispam-PRVS: <AM9PR10MB40873F672B2FE9E13E1A9639E9A19@AM9PR10MB4087.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiIWzClT0laOjNnU6jC+1tr2y9aov6zYSoYCAElj84fJ9hevEFi1gUeP2gkNXNs/ZDCSdNzLk3k3mhLviIecIYH6t2udpwRwize6cSedMKNhFKXaNrqIKCcP/FNzcD1FJfxdxkOXVn0RbeIO9W2HDnz1JSN8gyGZWghiKM6BHnpMmEbEbuGZUyfi6vO6VjB0xlHbTBFgdOkO0rvHul9xAppyti1l9YOlMtVIevM8+WJr84w1LiSBTwYN2D4xNwH6rXl8AusSPGGueL6C0+e01x2w5GRThFmp4rhH7XGNk/QhN4pbwrKl1a1WMupegcPpkUgPZS13L1ZDYLPgTwNNlHbQffyyNZIw6BngNpXq8mGi7eR1tZhI1mTDEX2oOCN5oDQm5AwySlaAe7FnwqmEyzYSAGd00OjMJJjgTNH9m9vKcDnL6m6hPVFMOoeWLRekdNqD3QfSXOZCzRvGCs/3TRZtzCha+1e0o1/91pKiZ64icPOP3cp1lIHwDSpsqR/arVOkfHv1T9jM+/Uu+cFNZwNnw3A/hyE5j//wD7QSQJk2XRSh5B6EHE/Vxpg5Yc9/SKb+3emNRdFxWxdUujKMEYczDUfMb2SjbA4iIh9VwOlAUT5emKvbXICTmN7UI3kXHVJQRbs2YP+W2ngYjP268gu/3mjg4lNa8/ZgyZ0dNBe6f+8gWAs5zz7ogEqho/gGziwEuUOlCa1TQ11WDT9xrJEtnWMJvToM8p4+iff9r/flbpWD5QFWwtk47EOErn1e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66946007)(186003)(2906002)(66556008)(6486002)(44832011)(5660300002)(6916009)(66476007)(2616005)(36756003)(7416002)(956004)(54906003)(38100700002)(86362001)(31686004)(31696002)(16576012)(8936002)(508600001)(53546011)(83380400001)(316002)(8676002)(4326008)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V29jNUh3bDNCWS8xNmhUZVkzMnJZajBiZDVUeTA1cE1sNzdETHJtRlhHYUd1?=
 =?utf-8?B?Sjk3QWN5RmQ2ZGIxcXhLQUp0dXBLbXlaOEpkYXdVVDlvL3NkMjZuV3VMYzky?=
 =?utf-8?B?S053OGhGODR5WjZwUlhxK25yRmtPeGwvQThMaDJ4b2RUV0d1aVVnZnBvNHZV?=
 =?utf-8?B?U2t4SjJsT1ZuUGxScWszTDVwK0VjcVhhN3A5eUpNK2o0MjA0azdodkQ4SUhl?=
 =?utf-8?B?VWQrNUZQcHQ0U05NdVNwUDRlQ0NMb0NBbzlGVTBjQnlRODRNam10YlhkdUNU?=
 =?utf-8?B?ODVzUG9USDBJSWE1eXdEazV4WUFxZGQzUW5OK2YxWmVSTFYyeUxBbGVVeXNa?=
 =?utf-8?B?eVBuZmlHY1Z3OUs4UStpZkQ3NjFQeFJ2bG9hTTZEOVBSSzdsRUsxU3ZvZDk2?=
 =?utf-8?B?T2I2RkpSSzZOSEZtZGtPMXFVWjBvazJ1WWUvWWJxL1BHeWJHdUZtUmgrbW1G?=
 =?utf-8?B?dXgxM2NYUXlKdG5DRGt3L0p4UG1RZEJoT3hFcHcvRGREUXpneGVVb2UyUm1h?=
 =?utf-8?B?cTBVanZ2NlNPU2QzMEhXMHlLaXViSWlZZ2pWa1pmaktzeXY4YlRQd0dTaFEy?=
 =?utf-8?B?Q0FoWXlheEtQTGNtUmt1RVZzcm5JdXVGSnJpWi8wako2SFAyNW0veHRzUDAr?=
 =?utf-8?B?MmZEcTFVL21XK29uVXRsL0VIRU5LZklYSDNHSkZMZ0ZjT2llcmNqL0xWV0pY?=
 =?utf-8?B?c1FBT21Ib2RUNnJUY1JTL3I1UXJzaVlzK2QxZGdicDRsVkNjWGRaazNEb2xw?=
 =?utf-8?B?YmwzT0F6YlN5ZWJ1YVRyTmhoU2lldWxHcTR5RXRuYjc0V2h3VkxSdnNDSDJw?=
 =?utf-8?B?c0ZjSjRjTVNITmh4dStnUWk3bW0xc0xLT1IyZVdMclQ4Qlo1VW4wVEl1V0RE?=
 =?utf-8?B?UkQweUdhSXR3Ym0zdTVzbGFGT21NdFhjZTRnRnNWc0p5VlZGTXNweTBrbEc2?=
 =?utf-8?B?cnljRXFNNXFZajRYMHNROG9Wd1lHY24rMjJtYThvWloxbXl5VFpTNXBIMHVW?=
 =?utf-8?B?T3I1a1hlQWFvbURWRGJVVS9JNEFiUHpvSHV2eERFZXhGckZ3WFR1RlVNYTRG?=
 =?utf-8?B?d0dKVCtCdGVCNy9KcWxyUmptY3dmaXhqanhMcmFYUVBjSHcwM2tYQ3Y5TlN3?=
 =?utf-8?B?WDk0aVpUTnZCeUM1d1Q5TmVhTnVEZHVmZWpqRWY4U3Z5TlZqK0liN1JCRGxU?=
 =?utf-8?B?OFhub1VyQVJneFd2Z0JYN21qVVB6N3BVVnpWQm9Bam5RTVFacVVyYzRXTUwr?=
 =?utf-8?B?WForeFVLTDJEY01ycncya2NwYm9PVFJrVkJMWWR2U0llaURtMUJCbm9SazlY?=
 =?utf-8?B?b1FHaUZiTEl6MmU0MkhSck90QlJpTi9zOUsyZjBkSUp6dWYySGNidjlEOGxQ?=
 =?utf-8?B?OUZaOWMzNkd4V1NlQmFpYlMwSDZaRlphbHU3V2tGMDV1US93Q09pRFhzL3h6?=
 =?utf-8?B?aUJKOWRnREpwN25JVGN2L3ltQ1o5WWhJOEZ2WGRNcW9obCtwaVhPZThSOVRV?=
 =?utf-8?B?S1pQcFdZa2dPQ3Q1SnMxN3RLSVR2Q2FFNGdjcFN3Y0VsZ0QxL2ZqY09LTEJo?=
 =?utf-8?B?bVNvYVkwVmYzWlY4WCsvbDRZZ2srSmdzN3hsUVFxc2JyYmNEOWhBNlZmUHVG?=
 =?utf-8?B?R05NUUUrWkw0ZVVwc2xoYzgyMWVnWlhMNjJ2WldFWklNL0YxK3ZLdXMvWHRZ?=
 =?utf-8?B?ZmcvbURKWkNjWElsNkdJbkxtNGdYd2EvT09UTHRNY0x3ZmZkTUJGWmtzRjlF?=
 =?utf-8?Q?w7YIEihNH5Bfu0WlgaJwYF6KJPwV11QMm/1ty5E?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5f6e4c-c988-493a-22e8-08d97ccb1d54
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:43:26.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM3dtZfeaCpEEaxdKZSF3hh46RRXVQJJCO0NMzU1L2WW2yB7lQtOtI7gm3qoYEgK/nn54IpyD1XyN71wCCrA3j9eK1cw75eU6xa3XBnX3Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.21 08:42, Frieder Schrempf wrote:
> Hi Fabio,
> 
> On 20.09.21 22:50, Fabio Estevam wrote:
>> Hi Frieder,
>>
>> On Mon, Sep 20, 2021 at 11:26 AM Frieder Schrempf
>> <frieder.schrempf@kontron.de> wrote:
>>
>>> Commit ed5a419bb019 ("usb: chipidea: imx: "fsl,usbphy" phandle is not
>>> mandatory now") explains, that the core driver already covers reading
>>> the "phys" property (see ci_hdrc_probe()):
>>>
>>>   Since the chipidea common code support get the USB PHY phandle from
>>>   "phys", the glue layer is not mandatory to get the "fsl,usbphy"
>>>   phandle any more.
>>>
>>> This seems to be the reason why ci_hdrc_imx_probe() doesn't return any
>>> error in case "fsl,usbphy" is not set. It expects that the core will
>>> handle data->phy = NULL and already checks for a "phys" property.
>>
>> chipidea core populates ci->usb_phy when phys is used.
>>
>> The charger detection function only checks data->usb_phy, so they
>> don't see ci->usb_phy that was populated by the chipidea core.
>>
>> We could change the signature of all charger detection functions to
>> receive struct ci_hdrc *ci, but that will be a huge patch that will
>> probably not meet
>> the stable requirements, so I think to minimally fix stable we should
>> go with the proposed fix I suggested.
> 
> Ok, thanks for the explanation. I agree. Would you mind sending the fix
> as formal patch?

Sorry, I just saw you already did.
