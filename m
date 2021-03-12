Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39CE33844A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhCLDQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 22:16:51 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.113]:28081 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhCLDQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 22:16:20 -0500
Received: from [100.112.7.19] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-east-1.aws.symcld.net id 9E/6D-49826-40DDA406; Fri, 12 Mar 2021 03:16:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGJsWRWlGSWpSXmKPExsWS8eIhly7zXa8
  Eg/M98hZnJwRatL/eymhxedccNosnC88wObB47PzewO6xfstVFo/Pm+QCmKNYM/OS8isSWDMW
  nFzAWLBcruLP31lsDYxfZLsYuTiEBBqYJE4fPsMG4bxilOia/5gZLrNq1QtGCOc3o8Sti5PAy
  hgFljJLtHRugXKOsUh0blrCBOFsYJTo/vUZrIdFYDezxPmfT6GmzWeSaG15C7XnLqPE05vLWL
  sYOTnYBFQktl07wQhiiwioSTSfagErYha4zCjx+fFCJpCEsECZxPVzn1ghirwkdnSsYoGwrSQ
  mPHwCFmcRUJU4+GoiG4jNKxAj8fTSfHYQW0ggTmLjpDNgczgFjCR6vp8Fq2cUkJWY9ug+WJxZ
  QFxi7rRZYHEJAQGJJXvOM0PYohIvH/9jhXhuAqPEylnr2SASChIv+z9CFclKXJrfzQhh+0p8/
  7IIytaS+DDrCZRtI3H0+QKgozmAbBWJf4cqIcLZEidfv2CcwGg8C8kZELaWxLyG30wQtqLElO
  6H7LPAXhOUODnzCcsCRpZVjGZJRZnpGSW5iZk5uoYGBrqGhka65rqGphZ6iVW6yXqlxbqpicU
  luoZ6ieXFesWVuck5KXp5qSWbGIFJKaWAfd4Oxo43H/QOMUpyMCmJ8kqt9EoQ4kvKT6nMSCzO
  iC8qzUktPsSowcEh0HH06BpGKZa8/LxUJQneF7eB6gSLUtNTK9Iyc4CJE6ZUgoNHSYT32w2gN
  G9xQWJucWY6ROoUoyXHhJdzFzFzfG9eCCSPzF26iFkIbJ6UOK83yDwBkIaM0jy4cbDkfolRVk
  qYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO+8m0BTeDLzSuC2AlMz0F8ivF6qYAeVJCKkpBqYDpz
  2/MI2beWS64wHvPeWO2hfq7n2Usmsv+xh0ZkjIudl1t7luszitT0sxfesY3rolJQFubf1F55u
  9fSvalw4uTz86cZzr2ubXKoWda6tU9s+zf+I7+KZCevu9J7ZpHRVLma/flWe4C3p76GmOolPr
  07mNLfRLPrzuSiIeSmLyc6zcm/qJ844e9RcuXafC2Nehbj7p1cfdIvqczr/nzhq+3bjSY7qv3
  2SE+3fbmUXrqk7eXbBak/Leylnqks3fF38o0AmofjJBPNCnUUlOvf1mRn/TVc856ip8Pys+Fq
  7+XLBZnufW9UH7V5c2OT+Ywn7/WIzRTHrPRlbjXIfXOj+0bLq1DvJfxeXOO9e2b1UWomlOCPR
  UIu5qDgRAGeOd4BpBAAA
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-3.tower-416.messagelabs.com!1615518979!1339015!1
X-Originating-IP: [104.232.225.10]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9226 invoked from network); 12 Mar 2021 03:16:19 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.10)
  by server-3.tower-416.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Mar 2021 03:16:19 -0000
Received: from HKGWPEMAIL04.lenovo.com (unknown [10.128.3.72])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 27C49A5699B256679331;
        Thu, 11 Mar 2021 22:16:17 -0500 (EST)
Received: from HKGWPEMAIL02.lenovo.com (10.128.3.70) by
 HKGWPEMAIL04.lenovo.com (10.128.3.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 12 Mar 2021 11:16:16 +0800
Received: from HKEXEDGE02.lenovo.com (10.128.62.72) by HKGWPEMAIL02.lenovo.com
 (10.128.3.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2 via Frontend
 Transport; Fri, 12 Mar 2021 11:16:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.125.57)
 by mail.lenovo.com (10.128.62.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Fri, 12 Mar
 2021 11:16:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIOtezKnhPkdu5ZpQ/SUFBjLl9UpHbnZkwUcgf5bHBMSBD6lg3ypcBOoQVBKCjJ0eNfddm3zFBOVXin7mO24wY7wHlOaIEMgdPJY7mhpMFPsNVnCKI09QWGUL1bYASg9Ld+cyVU896njOhSyGVunQIboFsMmDFtB6WqBr1lYC8+3tCducPeZjsNEzEZfrtaf3AVujvnZBoQBVwkezKm7WQQXvqUbuJJvs13Vb93diHMi6KRCdUVf7RxJubbI7mAWSc8ezzVvrpPn07XYBkWIOZW38CpA9Zu+9kIAMXPvJOFUy8Uzin+pIie8y3aEusDU9lGFGLdU1rfmQPPW1Vb/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAVDFeo5X/C/GjGQFK6eGLxo9B6dPcy0IN1agotlZTs=;
 b=dIUrvOHbDfV8888NHtqn0GPvvghHyZaqhums/FC8aBR+scUB5rbhZfjfv3VzP95pkUsRJPd6KuJxLH+IkvhTfPUsNqvUR2SOiqL6AaksNCj8mQbqtwEtFDCCnBx28wpDiRE3CTlFaUnD1D5I/6if12kxyPjtY83xxyl0NSIDoAqo7gObQS7iRivGqxyQTA4uZRQR2VMhIlrxrmTNusEOHKjtFGofyKMS7pUMm9Q5nkkeIOMBUGhoOz6P+WHLYyyZxnnZGRMtoSXTrDdO0s9akAeOL7hROVndKYCkruvIwzU9p36XJ+EHehsUb/ZtK3jTr4WvWb26Y9dcnGlj0MTCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAVDFeo5X/C/GjGQFK6eGLxo9B6dPcy0IN1agotlZTs=;
 b=mD15sxLgOz65GRLsoeLglq2qQesM+R0+C6eHw3xxYn49N1BbdcDQf9zJopTZNtxKtYd4zJygecsnLAV+toZKI1q4JlU/8+Jmt1IFSEx7PUEuz/ZN9RS6RCVUNdRKOipdn7apUceUBkkMNYILuze7HQ5MF0tpHqmKao0XzOC8o58=
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com (2603:1096:203:74::13)
 by HK0PR03MB4705.apcprd03.prod.outlook.com (2603:1096:203:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14; Fri, 12 Mar
 2021 03:16:12 +0000
Received: from HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::1d1c:1747:220:d4ba]) by HK0PR03MB3700.apcprd03.prod.outlook.com
 ([fe80::1d1c:1747:220:d4ba%5]) with mapi id 15.20.3933.030; Fri, 12 Mar 2021
 03:16:12 +0000
From:   Jiqi JQ9 Li <lijq9@lenovo.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark RH Pearson <markpearson@lenovo.com>
Subject: =?gb2312?B?u9i4tDogW0V4dGVybmFsXSAgUmU6IFtQQVRDSCB2Ml0gaHdtb246IChuY3Q2?=
 =?gb2312?Q?883)_Support_NCT6686D?=
Thread-Topic: [External]  Re: [PATCH v2] hwmon: (nct6883) Support NCT6686D
Thread-Index: AQHXEONlo6uqJyVBcEqZAQGxtj2EYqp/X3KAgABZ1NA=
Date:   Fri, 12 Mar 2021 03:16:12 +0000
Message-ID: <HK0PR03MB37000C8CD05ED2951F6BA336836F9@HK0PR03MB3700.apcprd03.prod.outlook.com>
References: <20210304104421.1912934-1-lijq9@lenovo.com>
 <20210311215055.GA36492@roeck-us.net>
In-Reply-To: <20210311215055.GA36492@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ba0c3fc-0bb6-4b2d-c191-08d8e505309a
x-ms-traffictypediagnostic: HK0PR03MB4705:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB4705F51F3B6423CFD6E11E24836F9@HK0PR03MB4705.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DF5WQq35uAmHbpNHnVD7JuxSo6PHkZZhax3VulWct0OSHGYJJ28ZezxqbhJn3GWoZfwIoXCJmYnGoy4cnrHDldsIK/WGLzoVPYu98yN5cMMz63C96dzd0Ym56MXUFQcjNdLa5W8szRLh9Ev3v6GGX5DIiSdpvdjN6nYSNGalqqjTkO0DXOcU69wB00ietDf6ScHTXZVJrUE/qjYsRnk/RKYt4G4YEor2sstb6hWyAGL0SPIeNFE5LGU0xRQSQmdz17xzbbMmy8FvAHfLkM+VitqxTjlGRaEBNpzi2I8pH9UrA859LsJyeSAnIcT+rMHU+HbdbLgLIzZd2G+6sAiKU7hONvzPFugen67AEIghBfC8c3nIpHZ46uir39AvBDJ0VgnSk3PTd4qlPGiqunL3bfIxRetxIj/trvfGTJ97zAqpFyBjr8j1FhES+nnG3+x+qgdGP4xtEghJM0v5oynS05zZmmWQXV677LWnQzdwb3SVnWzm4syRYKkunxgonIowndFwHK019iR+RN22ATi0L/V5hYMJ041Di9hqhjDaoQptTWL+L6cWkiR4Bq6ngZQ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3700.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(478600001)(55016002)(5660300002)(186003)(316002)(66556008)(64756008)(2906002)(52536014)(6506007)(26005)(33656002)(66946007)(66476007)(71200400001)(66446008)(76116006)(8936002)(9686003)(86362001)(83380400001)(4326008)(7696005)(224303003)(107886003)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MzNwb2t5ODV6Nm9CeXg1M0pXb0lTVWRhM3VOUURpVFJvNFFLeGlZeXhRVkg4?=
 =?gb2312?B?QUVWcWlqeEV2UzJjR0J0MFY2bWN4cUNzOXdMeTYrY3NKNmpHbm5zTzFPYzlT?=
 =?gb2312?B?SmRZU3AxUDJ3c3NBZWhnWjRwRWV0Q2ZPSW0vck9lVWYyZ2ZqSThWeFRYZnFj?=
 =?gb2312?B?U1d6SjhsUFhWMnlHdUgram8zcU9pVzFaRE1rbTN2UVcvNUZjd2p4WEM0OXVv?=
 =?gb2312?B?YkhNcXlaMnJBSHQra3ZDdUU2NkdPU0NNbU9LNno4TGZKMDBxZk1qdmRwQ2R4?=
 =?gb2312?B?YnQweHJscTFBdzk3V09wd0dHZFR3TlpoS1BJcjY3TVpDUEhIVXEzK0tTMS85?=
 =?gb2312?B?a21vazZiT1dqOUp6TGRDZnFQQm9MZDRMemRtblIxN0VBVlhBZ1NYbFFna2RU?=
 =?gb2312?B?NTIxL3F6NVZMNEtha3R1anZobXdRZkd6MWVhNGRFZGs5Ly82aEpEUWlIZmxv?=
 =?gb2312?B?bTRzUmZDb1pFR3BlZGVReFI3dnhrVnVmMVhXek9ab3dGakhCck56cnJnNXVh?=
 =?gb2312?B?V2d1bHNEalpSK3pZT2FGcjV4QjNva0RHOXF3dFlRckhsUmJNMTNuZVJDNXFm?=
 =?gb2312?B?WWRJWmpmb0I1OWIvdEdxUHpiOGRicjJmbUt1S2Y5aHpOcmpsUlZrbm5vWW4v?=
 =?gb2312?B?OEpsUWNvMXprQUZOTzNjVFNjR1BqdXNUbFV6RG1YcGE0aE5CZUQvTkh2QXl2?=
 =?gb2312?B?UzZWVVVSSmZSN1lVZXZIclMwK1lqY2pvNVF1Q05ESkFvWnV0ZXRUekxGM3FW?=
 =?gb2312?B?Z21TZ0lLNXBaN3l1aE1Xc3E4Vnk1L1FXZ2RuRHYxenNvK3kvSEZPRGFBSmVP?=
 =?gb2312?B?N0N2VWxJcC9jLzNyeThSN0pHZUpJQjlHdGN3eWdLT0FQWEV5SU9oSFlDUjdv?=
 =?gb2312?B?bG5PTTgyWXJwQkhMY0paWjFCMlIyZ3VWLy94U0plbnAyNmx0em5tRmszdDZ4?=
 =?gb2312?B?Y0UwZUJHZ1lQSjREVE9odzZsY3BQVjZaclZySklMR3NtdVhuVisrSzN0L3FP?=
 =?gb2312?B?bGR1Z0FHTVA5L09SMkh1TGdGcUtYNGdNSjBDM1JhN2d5SVorY3F3SGljbzZw?=
 =?gb2312?B?azJobTBLdnhTNGtpa3dyWjMxUmY5MU5Wb2JnOXNJOHJzK1Nia2ZBT2I2S0hz?=
 =?gb2312?B?QkhQYWttaWEwT3VQZ1ExR29JNkQ5NTJDL3FhTjhlTUVQTmtVTGRrbjZxQ2Ro?=
 =?gb2312?B?cUQyd01rKzlyZ1FhVEIvcnBjNjEwK01QR05zU1YyYnpMNkZLRGNBUXVvS1Ex?=
 =?gb2312?B?QmFJMUlIcXRFMjNSL1VHcUxHekgrV3FVbGluU1EydkRTWk9FRG5FdWhDL3h5?=
 =?gb2312?B?SFJJNHZrbkU2SjBzUE9lcGtselNhNDBaU05WVEJxdnZSRnhmQjJrblEzckl4?=
 =?gb2312?B?R1NFTitUTzZQQjV6b2NCTjFwY3ZJWExPdUpIdzBnSndlY2E2eWNGY0d4TlUw?=
 =?gb2312?B?bmZ1UWhROTdmdnFWb3NsQ2JTRC8zb3B3SVZkcXVjRDRPRkVyWkFBK1gyTlVM?=
 =?gb2312?B?U2FpTWFVYmRVVnZiWlZpN2xVZllKb0pLWkU2ZS82Z0tzS2ZvdHpVZ0xVQmZY?=
 =?gb2312?B?bi9hWWdGeFRJaC9iMnVuNC9lMEE0Q2dVaExtejhENSswR0J3ejd0OHBFTFQr?=
 =?gb2312?B?d0lBcmpXRGxpZ3VqT1IvRUIrWmx5cjdmdzQvVVBKQTZvSjNVTDIyTjc2M0Np?=
 =?gb2312?B?MUl4bS9tWnBhNS8vVGRKQnlKY1ZCZldqd1FrMDFxbVQ3YUFZQ2xCMUlYeEpw?=
 =?gb2312?Q?Di8CjaBen8K4t6DWPc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba0c3fc-0bb6-4b2d-c191-08d8e505309a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 03:16:12.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3T8NILLl+AFlbbcgtE+ZL0wBTdSf2mEk/fZZbrrhqpdaxBEZcH6nxMv8LfDFpcn86iOvI1VyH9GdLAM64VJOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4705
X-OriginatorOrg: lenovo.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R290IGl0LiBUaGFua3MgZm9yIHlvdXIgdW5kZXJzdGFuZGluZy4gDQoNClJlZ2FyZHMsDQpKaXFp
Lg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogR3VlbnRlciBSb2VjayA8Z3JvZWNrN0Bn
bWFpbC5jb20+ILT6se0gR3VlbnRlciBSb2Vjaw0Kt6LLzcqxvOQ6IDIwMjHE6jPUwjEyyNUgNTo1
MQ0KytW8/sjLOiBKaXFpIEpROSBMaSA8bGlqcTlAbGVub3ZvLmNvbT4NCrOty806IGpkZWx2YXJl
QHN1c2UuY29tOyBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IE1hcmsgUkggUGVhcnNvbiA8bWFya3BlYXJzb25AbGVub3ZvLmNvbT4NCtb3
zOI6IFtFeHRlcm5hbF0gUmU6IFtQQVRDSCB2Ml0gaHdtb246IChuY3Q2ODgzKSBTdXBwb3J0IE5D
VDY2ODZEDQoNCk9uIFRodSwgTWFyIDA0LCAyMDIxIGF0IDA2OjQ0OjIxUE0gKzA4MDAsIEppcWkg
TGkgd3JvdGU6DQo+IEFkZCBzdXBwb3J0IGZvciBOQ1Q2Njg2RCBjaGlwIHVzZWQgaW4gdGhlIExl
bm92byBQNjIwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmlxaSBMaSA8bGlqcTlAbGVub3ZvLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IE1hcmsgUGVhcnNvbiA8bWFya3BlYXJzb25AbGVub3ZvLmNvbT4N
Cj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6IENvcnJlY3RlZCB0eXBvIGZyb20gTkNUNjg4NkQgdG8g
TkNUNjY4NkQNCg0KTm90IGVudGlyZWx5OyB0aGUgc3ViamVjdCBpcyBzdGlsbCBwYXJ0aWFsbHkg
d3JvbmcuDQpObyBuZWVkIHRvIHJlc2VuZCwgdGhvdWdoLCBJJ2xsIGZpeCB0aGVuIHdoaWxlIGFw
cGx5aW5nIGl0Lg0KDQpHdWVudGVyDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2h3bW9uL25jdDY2ODMu
YyB8IDExICsrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vbmN0NjY4My5j
IGIvZHJpdmVycy9od21vbi9uY3Q2NjgzLmMgaW5kZXggDQo+IGEyMzA0N2EzYmZlMi4uMjU2ZThk
NjJmODU4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h3bW9uL25jdDY2ODMuYw0KPiArKysgYi9k
cml2ZXJzL2h3bW9uL25jdDY2ODMuYw0KPiBAQCAtMSw3ICsxLDcgQEANCj4gIC8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICAvKg0KPiAgICogbmN0NjY4MyAt
IERyaXZlciBmb3IgdGhlIGhhcmR3YXJlIG1vbml0b3JpbmcgZnVuY3Rpb25hbGl0eSBvZg0KPiAt
ICoJICAgICBOdXZvdG9uIE5DVDY2ODNEL05DVDY2ODdEIGVTSU8NCj4gKyAqCSAgICAgTnV2b3Rv
biBOQ1Q2NjgzRC9OQ1Q2Njg2RC9OQ1Q2Njg3RCBlU0lPDQo+ICAgKg0KPiAgICogQ29weXJpZ2h0
IChDKSAyMDEzICBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+ICAgKg0KPiBA
QCAtMTIsNiArMTIsNyBAQA0KPiAgICoNCj4gICAqIENoaXAgICAgICAgICN2aW4gICAgI2ZhbiAg
ICAjcHdtICAgICN0ZW1wICBjaGlwIElEDQo+ICAgKiBuY3Q2NjgzZCAgICAgMjEoMSkgICAxNiAg
ICAgIDggICAgICAgMzIoMSkgMHhjNzMwDQo+ICsgKiBuY3Q2Njg2ZCAgICAgMjEoMSkgICAxNiAg
ICAgIDggICAgICAgMzIoMSkgMHhkNDQwDQo+ICAgKiBuY3Q2Njg3ZCAgICAgMjEoMSkgICAxNiAg
ICAgIDggICAgICAgMzIoMSkgMHhkNTkwDQo+ICAgKg0KPiAgICogTm90ZXM6DQo+IEBAIC0zMyw3
ICszNCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPg0KPiAgDQo+IC1lbnVtIGtpbmRzIHsgbmN0NjY4MywgbmN0NjY4
NyB9Ow0KPiArZW51bSBraW5kcyB7IG5jdDY2ODMsIG5jdDY2ODYsIG5jdDY2ODcgfTsNCj4gIA0K
PiAgc3RhdGljIGJvb2wgZm9yY2U7DQo+ICBtb2R1bGVfcGFyYW0oZm9yY2UsIGJvb2wsIDApOw0K
PiBAQCAtNDEsMTEgKzQyLDEzIEBAIE1PRFVMRV9QQVJNX0RFU0MoZm9yY2UsICJTZXQgdG8gb25l
IHRvIGVuYWJsZSANCj4gc3VwcG9ydCBmb3IgdW5rbm93biB2ZW5kb3JzIik7DQo+ICANCj4gIHN0
YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19kZXZpY2VfbmFtZXNbXSA9IHsNCj4gIAki
bmN0NjY4MyIsDQo+ICsJIm5jdDY2ODYiLA0KPiAgCSJuY3Q2Njg3IiwNCj4gIH07DQo+ICANCj4g
IHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19jaGlwX25hbWVzW10gPSB7DQo+ICAJ
Ik5DVDY2ODNEIiwNCj4gKwkiTkNUNjY4NkQiLA0KPiAgCSJOQ1Q2Njg3RCIsDQo+ICB9Ow0KPiAg
DQo+IEBAIC02Niw2ICs2OSw3IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbmN0NjY4M19j
aGlwX25hbWVzW10gPSB7DQo+ICANCj4gICNkZWZpbmUgU0lPX05DVDY2ODFfSUQJCTB4YjI3MAkv
KiBmb3IgbGF0ZXIgKi8NCj4gICNkZWZpbmUgU0lPX05DVDY2ODNfSUQJCTB4YzczMA0KPiArI2Rl
ZmluZSBTSU9fTkNUNjY4Nl9JRAkJMHhkNDQwDQo+ICAjZGVmaW5lIFNJT19OQ1Q2Njg3X0lECQkw
eGQ1OTANCj4gICNkZWZpbmUgU0lPX0lEX01BU0sJCTB4RkZGMA0KPiAgDQo+IEBAIC0xMzYyLDYg
KzEzNjYsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBuY3Q2NjgzX2ZpbmQoaW50IHNpb2FkZHIsIHN0
cnVjdCBuY3Q2NjgzX3Npb19kYXRhICpzaW9fZGF0YSkNCj4gIAljYXNlIFNJT19OQ1Q2NjgzX0lE
Og0KPiAgCQlzaW9fZGF0YS0+a2luZCA9IG5jdDY2ODM7DQo+ICAJCWJyZWFrOw0KPiArCWNhc2Ug
U0lPX05DVDY2ODZfSUQ6DQo+ICsJCXNpb19kYXRhLT5raW5kID0gbmN0NjY4NjsNCj4gKwkJYnJl
YWs7DQo+ICAJY2FzZSBTSU9fTkNUNjY4N19JRDoNCj4gIAkJc2lvX2RhdGEtPmtpbmQgPSBuY3Q2
Njg3Ow0KPiAgCQlicmVhazsNCg==
