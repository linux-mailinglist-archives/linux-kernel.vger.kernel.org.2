Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260633B58FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhF1GP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:15:26 -0400
Received: from pop3.jakarta.go.id ([103.209.7.13]:63277 "EHLO
        mail.jakarta.go.id" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1GPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:15:25 -0400
X-Greylist: delayed 14396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2021 02:15:24 EDT
Authentication-Results: mail.jakarta.go.id; spf=None smtp.pra=a-latip@jakarta.go.id; spf=PermError smtp.mailfrom=a-latip@jakarta.go.id; spf=None smtp.helo=postmaster@zmtap2.jakarta.go.id
Received-SPF: None (mail.jakarta.go.id: no sender authenticity
  information available from domain of a-latip@jakarta.go.id)
  identity=pra; client-ip=10.15.39.86;
  receiver=mail.jakarta.go.id;
  envelope-from="a-latip@jakarta.go.id";
  x-sender="a-latip@jakarta.go.id";
  x-conformance=sidf_compatible
Received-SPF: PermError (mail.jakarta.go.id: cannot correctly
  interpret sender authenticity information from domain of
  a-latip@jakarta.go.id) identity=mailfrom;
  client-ip=10.15.39.86; receiver=mail.jakarta.go.id;
  envelope-from="a-latip@jakarta.go.id";
  x-sender="a-latip@jakarta.go.id";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 a mx ip4:103.209.7.13
  include:_spf.google.com include:_spf.mail.yahoo.com
  include:spf.smtpid.jakarta.go.id ~all"
Received-SPF: None (mail.jakarta.go.id: no sender authenticity
  information available from domain of
  postmaster@zmtap2.jakarta.go.id) identity=helo;
  client-ip=10.15.39.86; receiver=mail.jakarta.go.id;
  envelope-from="a-latip@jakarta.go.id";
  x-sender="postmaster@zmtap2.jakarta.go.id";
  x-conformance=sidf_compatible
IronPort-SDR: mPakuCp2WGWuwXYbP/eOEYBVXsKooDU+8R1OVVEIF+lCtekCgT5el4GTCt9/p4s8s5VfNvQmtE
 Zuwem5lqEoTw==
IronPort-PHdr: =?us-ascii?q?A9a23=3AieTz1xVwGtuLkpQaNk2PqxnnEqnV8KxgRTF92?=
 =?us-ascii?q?vMcY1JmTK2v8tzYMVDF4r011RmVBNSdsK8ewLON4+jJYi8p2d65qncMcZhBB?=
 =?us-ascii?q?VcuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMB?=
 =?us-ascii?q?x7xKRR6JvjvGo7Vks+7y/2+94fcbglVgDexe71/IRWooQneq8Ubj4hvIbstx?=
 =?us-ascii?q?xXUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohVbBXAygoP?=
 =?us-ascii?q?G4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5V?=
 =?us-ascii?q?yiu47ttRRT1jScHNiU58HrWisx2g6JQvQyvqQViyI7aYYGaKv5+cb7Adt8eS?=
 =?us-ascii?q?2dNQsNdWipcCY2+coQPFfIMM+hYoYf+ulUBogexCwatBO3o1j9FnWP23bQm3?=
 =?us-ascii?q?Og9CwzKwA4tEtQTu3rUttX1M6ISXPiswqfH0TjIcu1b1Cvl5oXUfB4sveyHU?=
 =?us-ascii?q?LVqfsbIzUkgDR/FjlSIqYH+PTOazOcNvHKB7+p8T+2jkWEnqwZrrjiu28ghk?=
 =?us-ascii?q?4/EjZ8axV7Y7yt22po1JcGmR05hZ96pCJ9duSGeOoZrXs4vQGFmtSc6x7Aat?=
 =?us-ascii?q?5C2YCYHxZQmyhPdZfGKboqF7w/gWeqPLjp1hH1odbK9ihiy/katy/DxWMay3?=
 =?us-ascii?q?V1XrSRFisHBum0R2xDJ98SKSuFx80ml1DqV1A3e6/lILV0omabBNpIswqQ8m?=
 =?us-ascii?q?5QXvEjZHSL7mEP7h7KMeEo+4Oin8eHnb63jpp+bKoB7lBnzMr8rmsyjGeQ4N?=
 =?us-ascii?q?RUOX3SD9eS8yrLj+Ur5Ta1Lj/0zjqnWqojaKdoBqq67GQBV0Zws6wyjDzi8y?=
 =?us-ascii?q?tgYkn4HIEhEeB2al4TpOlfOL+7kDfqnnligjC1ny+3GM7H7DJjAKmLPnbTgc?=
 =?us-ascii?q?Lpl7k5T0gszzdRR55JODbEBJer+VVXouNzcFBA5Lw20w/78BdV/zIweWniAA?=
 =?us-ascii?q?rWFMKzIq1OI6eUvL/ONZIAIoDr9MeQq5+byjX8lnl8QZa2p3ZoTaHC/A/RqO?=
 =?us-ascii?q?kCZbmTogtcGCmoKuRA+Q/bsiF2NTzFffXiyX7gk7DEhFI2mFZvDRpyqgLGZ2?=
 =?us-ascii?q?Ce7H5tWaXpDClCNHnbnaZ+EW/YQZy+JJc9hiCYLVb6uS4A/zx2uuhX6waJ9L?=
 =?us-ascii?q?uXI4i0YqY7j1N9t6u3XlBEy8yF7D9+H3GCNQGx5kG0FSiQx3KBlu0N9zFiD3?=
 =?us-ascii?q?rZij/xWD9xZ/+lJXRsiNZ7A0+x6DMj/WgbAftePVlmpXsupDSs0Tt0v2d8Bf?=
 =?us-ascii?q?0d9FMu4jh3Y2CqqGaUal7qEBJMq6K7c0WLxLd5ny3nazKkhk0UmQsxXOG2ih?=
 =?us-ascii?q?65/8A7TCJDNk0mDjKmlb74c3DLN9GeE0GWDp0ZYUBRqXqXDUnAQeFHardrj5?=
 =?us-ascii?q?knaVb+hFawnMhddyc6FMqZKbtzpjVFCRPj5ItjebWWxm3qqBRaSx7ODcpDqd?=
 =?us-ascii?q?n4a3CXHEkcElQ8T8micOQgwHCeuv3zRDCByFV3xe0ns6/VxqGunTk8oyAGHd?=
 =?us-ascii?q?0lh17uz+hEPhfyRUPQT3qgetycnpDV7Akyx38nQC9CYvQpuYL1cYc8h4FdAz?=
 =?us-ascii?q?W/Zsw19Ppq9IK94gV4TaAN3v1nq1xptDIVPjM8qrH02wwpvM66Y10lBdzyA1?=
 =?us-ascii?q?5DqJrLXMnXy/Ayoa6PO3lHe0dCW9boV5/k5q1juuAKkG0k5/nV+ytlZyWeT5?=
 =?us-ascii?q?pLPDAAKS5L+Tl439wRmp7HdeiQ944LU1XtxPqauqTLCwcwmC/YkyhaucddfN?=
 =?us-ascii?q?bmLFA72E8EAG8euL+kqkUCzbh0YJOBS6LI0P8S+evuC2a6rOvtvkyikjWRa/?=
 =?us-ascii?q?Y9yzFiA9yxnR+7SwZkK3vCY3gWJVzf5llihs8T3lZpYajEVG2q10TLkC5JJZ?=
 =?us-ascii?q?q1uYYYLDn+jI8m2xtV4nZHhQXFY9Fy9CFMcw8+pZQCdYEHm0A1Ky0sXumCom?=
 =?us-ascii?q?TamwDBulDEptKWf1jTUw+v+bBoHJnJLRG56gFfoIIi0issVXFK2YAgtiRul4?=
 =?us-ascii?q?F31yLJfpKtlNGTTW0BIcDT1L258Tquws6CNY89L6J8yrSpXV+G8a0iASrHhu?=
 =?us-ascii?q?xsazz/jH2xGyTA/djGqvJL5nxh7iGKDMnlztmHUedpsyhjE6t3cRORd3j0cR?=
 =?us-ascii?q?Cl3kTPXHESzP8G1/dWIkJfOquS+V2OlVpxTayXryJmPuzC85W1uAB2wheu+m?=
 =?us-ascii?q?sb6Hgcm1i/7yt9qVTnIrRrmfobkzb62Me1gfkl2HFX88dZ1Gplikossg5Edw?=
 =?us-ascii?q?XwahpST/XUZi2j+Ks5b1rz5bHUXXj4H2cLa4A/g2Ed7NHKG25r5VmmBwstmf?=
 =?us-ascii?q?9S6ZmIW2iQ87s9QDKeU7adJnTB2olu4qwLef+R9ki0GxvQw8HQamf0GuBIxz?=
 =?us-ascii?q?iWBBbAfBU1YPS3qlxuV9d++qbhXZHy3cbiw1EtzhsuhDb+Zog1GWXb2ZI8oH?=
 =?us-ascii?q?TVs4cVnLFLMzHrz55ngeNnRatITsAObkxPag+dPLJIxkuAFhS9mOWLyo3Ilz?=
 =?us-ascii?q?Og7gAdy3Z6kuIiINXth8Li3Ah5CLjf1fd8c+inxjaZCmcabx4SvHpRnGjoWR?=
 =?us-ascii?q?pTnUeynECkIuvT9LAuODD08pWmFFrXCEg+Q9klnr3XVE5CvKn6WKngZwsh8S?=
 =?us-ascii?q?xWHOENfhwUUVi0gnpElDgCq2NDhcEBh6zAV5174rAZDxfh0OBbhSWfQvh2oZ?=
 =?us-ascii?q?ywoSJifMhVZ8BxN50jLPs2Q6eJzBSVY8YCvrQyMMGyUeR5EAn0OWkyBH1rjJ?=
 =?us-ascii?q?KWh5cHc8+iEAeqzN//OYbSLqeNFUPeIwImg0ox98jaRMMWPPmVtD+ch1kpER?=
 =?us-ascii?q?3B5FNzTmy8TRCwPiyLNc8mbqQ+4+i12qMCw7e7kVBj15YSVEbRdLM5i+w2tg?=
 =?us-ascii?q?aeBLeKfmjt2KStC2pMI3nDC0KIf00IKiyFyazmtFqwNtSrMTKLWh6BXFAQUa?=
 =?us-ascii?q?iNqOMtL7qI8xBVCOc7Ah9Poyr54k/o1C0xfWlD7hM6meNEKKXmnNFzbHEaLK?=
 =?us-ascii?q?KiGJTrTzsHzYKO8T6BQjepNux2zpzmbCUnjMSqHlzTySRCvPv9DjDuBMBxdp?=
 =?us-ascii?q?o69aBBtBnbnTN78bR27KtB3hyUswbIonnPKKXIcMT9kfkNJr72Q6z5Yg/pmF?=
 =?us-ascii?q?2xH8HVlMfKJmziW7+bGMJYaq/hrDTpul+Jc/ns6z6FZ7CZeRPx6gCHStMJho?=
 =?us-ascii?q?0m6kumTzTpqSB5OqjdNhIKLo0ViOb7U9odBWXna4BIN8XufCxAQq9R5Dd3vv?=
 =?us-ascii?q?rpcysbJlKjrMjdN78rU/dcAB8jTMM+HNHshMR7oGD7KEgQITzqmOHrBh0xak?=
 =?us-ascii?q?fGS8meaooI0qpj2gJAOUKNUVEQpFvMGDURoBNgCIJZzXjIkj7KXkNIE6Walo?=
 =?us-ascii?q?RnPQ8Vav5THWeiIDfXhMjaTlaNEaAcQwbPkMYQTMZX220hjall/hovKB1DfU?=
 =?us-ascii?q?cpXrSJ8bA87ulhC8H9lQ20t3ELlawet72UJGf66hB48khF+bvg19Dfw/1c3I?=
 =?us-ascii?q?ULHpC8xkEk3hdrqmzORfyTqIaeuWoFWCi70uFIrPpP1WQZ/dReyklB8NDfYW?=
 =?us-ascii?q?7JRiKNtdWRqiA/apJRAA+VRTbNDYB8RwfGYfe8k0VpGqi+/309I+fPFCYd+l?=
 =?us-ascii?q?AstaZOsq3NA2wZnbN4yOKzcPq5Jzl9NhqKKuS+oy/s8wQEEKEYL6mydZSkIu?=
 =?us-ascii?q?EsSOrkoPSqi5vZs5hCamztfZGgMUOInovZr9kM7JeuM1Sbg3KBMKkCrLeOfK?=
 =?us-ascii?q?b6Wt3bbmM+GWFww0FkHmFRC/bhxy8sjfVCUXVg1zLSNDxQJKdbCKQZNYspW9?=
 =?us-ascii?q?XjTejyCsf7TzpJoJYW9DP7nQPSAtakOhEKrBhsmH4ML7sgbEJmsylnSLd37I?=
 =?us-ascii?q?74d1RUt+APrKU2BDPRIfxKLnjMHo8a8wZJ1xoRcKCsSAWNnPiqq4bbXoRUmg?=
 =?us-ascii?q?PSZXN0ueHcVQpMENm4qWM29gyNZu3VADD+p3e0E1geC6z/8qTrNDDnmcdVuf?=
 =?us-ascii?q?/mVaglqCN6s5Do/9K+2hUTZ8pXEJmH1KdVisMfV6ewGv5aHF+9UTb5lvkfYm?=
 =?us-ascii?q?olYQXOqU2HOEdKsKZnxa5MsbcfoBXa6SVG+hSw6QNzrMNmwMKeCmRvoSppMs?=
 =?us-ascii?q?ImHwDAjMtewFjUfGxd2uu4D/7hzZA0bbJo0ZR7nrRkxOLG+IAee3dWjWGisK?=
 =?us-ascii?q?TxMT/lb0Oq6eb1XzzEtbu+9znssVI01wPOv+04XWJ4Klg3exeqkZ4RGVSjzG?=
 =?us-ascii?q?3hdewTTqio+i2huKP09wuYjzx7TsVgTKTCLdOtuaGBeo94zH0uYIW9qBWogW?=
 =?us-ascii?q?1+ckY3D7xao37AT+ytdnMtU3vBfsHfkpZLeYCijWKysqZXSqSYvccIpqbVrM?=
 =?us-ascii?q?YP/OsuGqI/enjvHQZnUsw2FVC67F/ldmthWPS1XXuJFmGE/NswGvopB7lA9W?=
 =?us-ascii?q?dskKLZXEqkjuqiqaSZ4DS4V1SIZU4KA3DgCg+e5xrTalhSQfY8iMRMesJVCh?=
 =?us-ascii?q?dwdXzRqbSwEvKWjTZnZl3eYSmgXJwce9QBM5AMGloBtZO/q+I7IQ4VWyz5Rv?=
 =?us-ascii?q?vJ0STDLGYdz+lr7UG6WgV/4SPK7n+O1xw1Y1Ojs3cUDWB5jFUhdwP5blk8pK?=
 =?us-ascii?q?LFxNqYfpJLFsj+SekPguGLtyfemK0dKxMzUbVL4DI3FtW3mXiIA43IeXZVPx?=
 =?us-ascii?q?23HFZQOjwp5b74mpFFNIICgZEn+5Tskx593ELmgVcCn2UopoWgdSiaqCdVBC?=
 =?us-ascii?q?+ZmsFXNVDJ5eZ+hsI/lNIlKQm9M5J2drE9UkEFsMy6/yZpTNcRN7SQWXDhJp?=
 =?us-ascii?q?jWQp9uzR9dD2c9xCJ8AOMtwtG3lEqNeJJeRu2E2uqDoynLB/zA8sVG6xDKuG?=
 =?us-ascii?q?6CgVO1W4XEeGhkpJmmFqkggFess8mDV8lzXrl975f9RBqKTgkVpvDZ9ApdOC?=
 =?us-ascii?q?y5N1XCkKVRyTWFJs+BAJ6vJacNcXuEyZQW0Nh0+D/Em30uJ/UZukXjlZSx4r?=
 =?us-ascii?q?hFa9DzFXwkoSSkVha/gmTkfqsGjOD8VUYlIbTUmbyfdMw2bgjtYvRZEZkBqQ?=
 =?us-ascii?q?Z8ZAtFF+7YB0YRI+crOU0esJjxWFDJ4MQdt9td23WVqlmy0UGiJBE+sfOrOq?=
 =?us-ascii?q?jV1dMSYttKgavv+ugZL3NC0+Nsk/rkOEiX10TamRsrT+tSk3jXrnk6HdaO+M?=
 =?us-ascii?q?eS/aGXdRX7DilaxieRsFIHEqg7UNgcTMJxm0Tw8e5G0ACvPNAhHP4oZLklST?=
 =?us-ascii?q?7xzL9pB5OFWNId/YKhcwaJ3Az+dXBT1UJeqsOEAK1/SQTrEKCDU+6m7qJ7S9?=
 =?us-ascii?q?ZTfQOvpfNCFgXnABaN7bd9h8TeuPbDs3MdF/1bunPdg8kQvUV/dLyWIt8jsP?=
 =?us-ascii?q?CsZ4dWrbhGkvJQqFCnKCdF/lzzsyimsbuIxRCunuNQdwZJdrnT5SutizkG1v?=
 =?us-ascii?q?+oU9rU2oY8wq6tkz8u5P+/bNOhavEl7AxOVGhQPlN1lAW5xQHpUa/MQL/GZd?=
 =?us-ascii?q?LoQjMTnoeT6X6IN7xjd9+tcYNrBb0bP0sD6DjiASARsng4CoCQGJ02T0LiEl?=
 =?us-ascii?q?+4RK47tpOT03F4s/0nrNgQPn/hm4YaJ/LbNpfeCNkOXlOVCAfmsFp2gy9Zk8?=
 =?us-ascii?q?1mf7vAlirMUL2l8YgnhEuEeX9QBzyHvyuYrwXFJcYuLErT+9fpET398kCjnn?=
 =?us-ascii?q?sU3FhASE+8VBZKJ9IdXhHsx3ePecNwaOPMn+C7HBVu/H7kOxGT+oSLSJGB5g?=
 =?us-ascii?q?wnm0RjzSHmv5Rn5qml5TWGfqrWr2loQXb6xC0BIWiOvMkItqzKDMj3js9/vs?=
 =?us-ascii?q?Lg05kU7WoD9nOqAjm6MIqlQBYW/IdWdJW82rVEeloE4ANOon4EXS5K2KdEX9?=
 =?us-ascii?q?202ZfzE8W6gjytQxsUPz4vY/syP4u/aATG7gquWpq/FzS1EynU+oVA068yxf?=
 =?us-ascii?q?vDI6dqQRv201mEXByllvA6JUxmwo73d51caXC7DmE6OnIUWP8lx33A731v67?=
 =?us-ascii?q?a4sR5Qy+EQWF4rNYe8DuSGmPTL1xViFZNdkM0vWmzBTH1/zDRx5AP1lgCSp4?=
 =?us-ascii?q?YSSxDGApQ5gXIR7ek35iAYiCow5LQQv4Vse2DYKVwcKLxGXX9TKTQzoK5UJU?=
 =?us-ascii?q?U8bZFGJxr+/L+0+mEl63rK3zO3abuVmG6NLOfEbjwLEzz05UtoG9LYTRr5xY?=
 =?us-ascii?q?QoX/evTrxTjE6DlVvvvj2Y5c/KyBMFWu5N81TNq8kO0QByu7o1G5rAQhcWTd?=
 =?us-ascii?q?6JKVpPLudh180Zt4TNcPjwImhV0iAm1FPwNvO22qMaOq4Kms6z9McRlD/VS7?=
 =?us-ascii?q?RU/AH5yyof9kEx268+CzP9SE8XcwYHvuAFVfyzT4N2ciUEtb7VIctnOHv4o9?=
 =?us-ascii?q?nMMIzUSKiA5JsKYLfY75CBpPXPY4FkKA8UHYc4UMZj6ghhazEjgWbUV58PbH?=
 =?us-ascii?q?VjeAIB2EqJgp2vxwzQo/ZZuSf7uriSzOYje4xdPNvBKljll0t3F4ukZiezbD?=
 =?us-ascii?q?CxdiZWAQz5yxC7Ki5yECvK2/+yPwcvIXhUJGWg3X9UVIj3K4gGhSuev3Jz0T?=
 =?us-ascii?q?gOZ7NPyi5MiZSfyDjSwmqoCqKNFDe9HjG3ywDFfEon/g//dvcCr7SNbsVhOE?=
 =?us-ascii?q?YA76hOgeu0XJpJgJRHxjdWmXGBuAzf2YJuSdBMtsfCKz6ED5KN/Owq2ZIMWJ?=
 =?us-ascii?q?A4F16Ov6XdRSVgLKva+tVKYUOQNIdp+Haqc6CkIr9kxbf9RbxCHqZfnrylFs?=
 =?us-ascii?q?gUzCQ4tLr05rTVAakCIkwoTWqqn3dxIwgYaT9N9vldBXGyqP2drrTOCUa1Jj?=
 =?us-ascii?q?bG5CvUW+y+PR+oBVANpPmktJnH9kIUrYLavkf1d5ylemThhpfExzzF8bAm5p?=
 =?us-ascii?q?ST0/eQP0DEp4q2x8joG/31JBLb78W+AGRBIy/IEir0ZAnDp5AmnYXUNW4D15?=
 =?us-ascii?q?aFuOcXq8YRJC5EXYxwgdjcaVKKvDGfxg/HQamRumMBZmBeV4oPMZLy6NzQbc?=
 =?us-ascii?q?Ls6jxPvFSAVOuf2nh9r+XEXS3Ov65klKNfjUfs=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1jO20KiplwgPMWBaFiel0DCUbnBQXugji2?=
 =?us-ascii?q?hC6mlwRA09TyX+rbHWoB17726TtN5yMEtNpTnkAsa9qBznhP1ICOUqTNWftW?=
 =?us-ascii?q?rdyQyVxeNZnO7fKlTbckWUnIM9tZuIGJIObOEYeGIK9/oSlzPIburIuOP3i5?=
 =?us-ascii?q?xA0t2ut0uFkjsFV51d?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EZGQDtL9lg/1YnDwpagQmDe2GBHwQ?=
 =?us-ascii?q?mFguDfz6QHwEBAQEBB4EJBDOKUAECDYZJijyBaAsBAQEBAQEBAQFKBAEBAwO?=
 =?us-ascii?q?BBYNHJYJOHwkDNBMCBAEBEwEBBgEBAQEBAwMEAQECgQCFVhINgjgMGXmBCAE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEWAh9STBsXHQEBJAETEQEGHAINGQIjOBdbghe?=
 =?us-ascii?q?CVQMJjzGcCoEygQGCBwEBBoJXgmgNgj0JgRAqjyqBEIEVMwOCbYFCgRyBbwE?=
 =?us-ascii?q?SAYM4FIJQgxczOmlFdmgNn1yHPYNLkQtMDy2CfY4ghXiEHIVkJpUSkHalNpA?=
 =?us-ascii?q?QZYVzOYEOcIJeCoFBUBcCDo42hiOIIGc4AgYBCQEBAwmLG4ERAQ?=
X-IPAS-Result: =?us-ascii?q?A2EZGQDtL9lg/1YnDwpagQmDe2GBHwQmFguDfz6QHwEBA?=
 =?us-ascii?q?QEBB4EJBDOKUAECDYZJijyBaAsBAQEBAQEBAQFKBAEBAwOBBYNHJYJOHwkDN?=
 =?us-ascii?q?BMCBAEBEwEBBgEBAQEBAwMEAQECgQCFVhINgjgMGXmBCAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEWAh9STBsXHQEBJAETEQEGHAINGQIjOBdbgheCVQMJjzGcCoEyg?=
 =?us-ascii?q?QGCBwEBBoJXgmgNgj0JgRAqjyqBEIEVMwOCbYFCgRyBbwESAYM4FIJQgxczO?=
 =?us-ascii?q?mlFdmgNn1yHPYNLkQtMDy2CfY4ghXiEHIVkJpUSkHalNpAQZYVzOYEOcIJeC?=
 =?us-ascii?q?oFBUBcCDo42hiOIIGc4AgYBCQEBAwmLG4ERAQ?=
X-IronPort-AV: E=Sophos;i="5.83,304,1616432400"; 
   d="scan'208";a="7618472"
Received: from zmtap2.jakarta.go.id ([10.15.39.86])
  by mail.jakarta.go.id with ESMTP; 28 Jun 2021 09:12:53 +0700
Received: from localhost (localhost [127.0.0.1])
        by zmtap2.jakarta.go.id (Postfix) with ESMTP id 94A2F6228AC7;
        Mon, 28 Jun 2021 09:12:51 +0700 (WIB)
Received: from zmtap2.jakarta.go.id ([127.0.0.1])
        by localhost (zmtap2.jakarta.go.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ql4rkQk2ZLnp; Mon, 28 Jun 2021 09:12:51 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by zmtap2.jakarta.go.id (Postfix) with ESMTP id 77E3F6228ACB;
        Mon, 28 Jun 2021 09:12:47 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtap2.jakarta.go.id 77E3F6228ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jakarta.go.id;
        s=zimbra-mail; t=1624846368;
        bh=CzGe/jxqZ9up0eD9xmwxBC4lk2k4SNiWKZP7B7QNrxs=;
        h=Date:From:Message-ID:MIME-Version;
        b=G3fQsOTXkCjaN4Yp7LxoAJLbepL6CQelKWIGeyDBPCHTSaB6dypbjxsu2RCykgqcm
         hpgunhK0jLTOyLXAhOSeylF3+Pw5nxxQusHR8DoRKlQxMJn+I35Sktv4AxgPCCT8Vy
         SRJepkifbeHauWISUq9LqYGuxVy3fUTeEO72RfCZU8PmdPdx8bn3iEoY/rpC/POgNm
         DW1SsFwBuG4zI5oK8pWNLkUFvY2Nb/14/oY/MAsfm/lr1hNq2qG0z+73yp7ME8D/QG
         G4sYEfCphyjqCc+Kx/PUo8kuxPhCLN14wLBnOGoknoqJ/arg0zE0RJMEIeLXcBIIM5
         XroOpE9mph4Ew==
X-Virus-Scanned: amavisd-new at 
Received: from zmtap2.jakarta.go.id ([127.0.0.1])
        by localhost (zmtap2.jakarta.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EhWkDv7842Z0; Mon, 28 Jun 2021 09:12:47 +0700 (WIB)
Received: from zmailbox2.jakarta.go.id (zmailbox2.jakarta.go.id [10.15.39.84])
        by zmtap2.jakarta.go.id (Postfix) with ESMTP id 4D61161F91DE;
        Mon, 28 Jun 2021 09:12:42 +0700 (WIB)
Date:   Mon, 28 Jun 2021 09:12:42 +0700 (WIB)
From:   OEA CANADA <a-latip@jakarta.go.id>
Message-ID: <1105622959.1316184.1624846362216.JavaMail.zimbra@jakarta.go.id>
Subject: RECRUTEMENT INTERNATIONALE OEA 2021!
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.15.39.85]
X-Mailer: Zimbra 8.8.15_GA_3955 (zclient/8.8.15_GA_3955)
Thread-Index: 64H9GhTeXpWBnx+tct1ej+PQnLNbGQ==
Thread-Topic: RECRUTEMENT INTERNATIONALE OEA 2021!
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Organisation des =C3=89tats Am=C3=A9ricains (O=C3=89A) pour le D=C3=A9velop=
pement International (OEA-CANADA)
Scan 4460 Hacienda Drive TORONTO, CA 94588- CANADA
E-mail: oeacanada@gmail.com
****************************************************************
L'Organisation des =C3=89tats am=C3=A9ricains offre des possibilit=C3=A9s d=
'=C3=A9tudes et d'exp=C3=A9rience internationale. Dans le cadre de notre pr=
ogramme mondial de travail (Objectifs de D=C3=A9veloppement Durable) pour l=
a campagne de l'ann=C3=A9e 2021 et l=E2=80=99instauration des projets in=C3=
=A9dits, le Corps Commun d'Inspection (CCI) de l'OEA CANADA a instaure le r=
ecrutement de nouveaux personnels dans les Organismes du syst=C3=A8me des N=
ations Unies (ONU) a travers le monde par le D=C3=A9partement des Ressource=
s Humaines de la Direction R=C3=A9gionale Europ=C3=A9enne de l=E2=80=99OEA =
commise a l=E2=80=99=C3=A9tude des DOSSIERS DE CANDIDATURE. Le th=C3=A8me d=
u recrutement international avait =C3=A9t=C3=A9 propose par le Secr=C3=A9ta=
riat de l'ONU et approuve par plusieurs autres organisations participantes =
au s=C3=A9minaire. Ainsi, pour la promotion de l'emploi et l'insertion prof=
essionnelle des jeunes dipl=C3=B4mes pour atteindre les objectifs du PNUD e=
t r=C3=A9duire le taux de ch=C3=B4mage, apr=C3=A8s l'embauche des 25.000 no=
uveaux recrus a travers le monde au cours de l=E2=80=99ann=C3=A9e 2018, qui=
 font d=C3=A9j=C3=A0 carri=C3=A8re au sein des organes de l=E2=80=99OEA CAN=
ADA lance a nouveau la campagne de recrutement international de nouveaux pe=
rsonnels toutes cat=C3=A9gories confondues, sans distinction de race, de na=
tionalit=C3=A9 ni de sexe a travers le monde entier qui feront carri=C3=A8r=
e sur les continents Europ=C3=A9en et Am=C3=A9ricain selon la r=C3=A9partit=
ion du comite de recrutement.

PROFIL D'EMPLOI:
1-Avoir entre 21 et 65 ans au plus.
2-Etre de bonne moralit=C3=A9.
3-Etre disponible a voyager imm=C3=A9diatement.
4-Savoir bien parler le Fran=C3=A7ais et ou l'Anglais.
5-Etre titulaire du baccalaur=C3=A9at au moins ou tout autre dipl=C3=B4me p=
rofessionnel sup=C3=A9rieur.
6-Avoir acquis d'exp=C3=A9rience professionnelle serait un atout.

Pi=C3=A8ces a fournir:
- Un curriculum vitae (manuscrit ou saisi sur ordinateur)
- Une Lettre de motivation
- Une photo d'identit=C3=A9
- les copies des dipl=C3=B4mes obtenus
- Copie d=E2=80=99une pi=C3=A8ce d=E2=80=99identit=C3=A9 (Passeport, Carte =
Nationale d=E2=80=99Identit=C3=A9, Permis de conduire ou toute autre pi=C3=
=A8ce d=E2=80=99identit=C3=A9 valable) en cours de validit=C3=A9.
- les attestations de travail ou les certificats des services rendus (si vo=
us en disposez).
(Tous autres documents juges utiles peuvent servir).

-TRES IMPORTANT: Veuillez envoyer votre dossiers a l'adresse email OEA CANA=
DA: oeacanada@gmail.com

#IMPORTANT: Seul(e)s les candidat(e)s pr=C3=A9s=C3=A9lectionn=C3=A9s seront=
 contact=C3=A9s pour suite du recrutement.
Postulez d=C3=A8s maintenant et connectez-vous =C3=A0 votre carri=C3=A8re.
#Offre valable jusqu'au 28/JUILLET/ 2021
#URGENT =C2=ABPartager ce message avec vos Amis, votre Famille ainsi que vo=
s contacts merci=C2=BB
=C2=AB Ce message vous ai adress=C3=A9 depuis la Direction OEA CANADA=C2=BB
=C2=A9 Programme 2021(OEA) Direction OEA CANADA - All Right R=C3=A9served =
=C2=A9
